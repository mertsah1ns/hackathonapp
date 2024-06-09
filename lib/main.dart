import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANKA İHA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(
            color: Colors.black,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Firebase initialization is still in progress, show loading indicator
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Error occurred during Firebase initialization, handle error
            return Center(
              child: Text('Error initializing Firebase'),
            );
          } else {
            // Firebase initialized successfully, return login page
            return const LoginPage();
          }
        },
      ),
    );
  }
}
