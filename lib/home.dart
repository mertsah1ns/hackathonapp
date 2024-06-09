import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;
  Location location = Location();
  LatLng currentLocation = LatLng(0, 0);
  String windDirection = "Yükleniyor...";
  double windSpeed = 0;
  Set<Circle> circles = Set<Circle>();
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _getLocation();
    _getCirclesFromFirestore();
  }

  _getLocation() async {
    try {
      var locData = await location.getLocation();
      setState(() {
        currentLocation = LatLng(locData.latitude!, locData.longitude!);
        _moveToLocation(locData.latitude!, locData.longitude!);
        _getWeatherData(locData.latitude!, locData.longitude!);
      });
    } catch (e) {
      print("Konum alınamadı: $e");
    }
  }

  _getWeatherData(double lat, double lon) async {
    var apiKey = "382de6c33f298205e3d891923dab1ca9";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');

    try {
      var response = await http.get(url);
      var data = json.decode(response.body);

      var windSpeedValue = data['wind']['speed'];
      double windSpeedMeterPerSecond =
          windSpeedValue is int ? windSpeedValue.toDouble() : windSpeedValue;

      double windSpeedKilometerPerHour = windSpeedMeterPerSecond * 3.6;

      String windDirection = _getWindDirection(data['wind']['deg']);

      setState(() {
        this.windDirection = windDirection;
        this.windSpeed = windSpeedKilometerPerHour;
      });
    } catch (e) {
      print("Hava durumu verileri alınamadı: $e");
    }
  }

  String _getWindDirection(dynamic degrees) {
    double degreesDouble = (degrees is int) ? degrees.toDouble() : degrees;
    const directions = ["K", "KKD", "KD", "KGD", "G", "GGD", "GD", "GKD"];
    return directions[((degreesDouble % 360) / 45).round() % 8];
  }

  _moveToLocation(double latitude, double longitude) {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(latitude, longitude),
        14.0,
      ),
    );
  }

  _addCircleToFirestore(Circle circle) async {
    await _firestore.collection('circles').add({
      'latitude': circle.center.latitude,
      'longitude': circle.center.longitude,
      'radius': circle.radius,
    });
  }

  _getCirclesFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('circles').get();

    Set<Circle> newCircles = Set<Circle>();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      double latitude = data['latitude'];
      double longitude = data['longitude'];
      double radius = data['radius'];

      newCircles.add(
        Circle(
          circleId: CircleId('${document.id}'),
          center: LatLng(latitude, longitude),
          radius: radius,
        ),
      );
    }

    setState(() {
      circles = newCircles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Geri navigasyonu engelle
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ana Sayfa'),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: currentLocation,
                ),
              },
              compassEnabled: true,
              rotateGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              circles: circles,
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Rüzgar Hızı: ${windSpeed.toStringAsFixed(2)} km/s",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Yön: $windDirection",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.warning),
          onPressed: () {
            _addCircles();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  _addCircles() async {
    Set<Circle> newCircles = Set<Circle>.from(circles);

    // Önce Firebase'e çemberleri ekle
    for (int i = 0; i < 3; i++) {
      Circle circle = Circle(
        circleId: CircleId('circle$i'),
        center: currentLocation,
        radius: (i + 1) * 20.0,
        fillColor:
            [Colors.red, Colors.orange, Colors.yellow][i].withOpacity(0.3),
        strokeWidth: 0,
      );

      await _addCircleToFirestore(circle);
      newCircles.add(circle);
    }

    setState(() {
      circles = newCircles;
    });

    // Çemberleri belirli bir süre sonra kaldırmak için zamanlayıcıyı ayarla
    Timer(Duration(minutes: 1), () {
      setState(() {
        circles.clear();
      });
    });
  }
}
