import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  Future<void> _register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        print('Passwords do not match');
        // Show SnackBar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Şifreler eşleşmiyor'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Kullanıcı başarıyla kaydedildi
      print('Registered user: ${userCredential.user!.uid}');
      // Show SnackBar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Başarıyla kayıt oldunuz'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      // Hata oluştu, kullanıcı kaydedilemedi
      print('Error registering user: $e');
      // Show SnackBar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kayıt olurken bir hata oluştu: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color customBlue = Color.fromRGBO(38, 65, 125, 1);

    return Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
          title: Text("Ormanlar Nefesimizdir"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
          Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Logo
              Container(
                width: 190 ,
                height: 190,
                child: Image.asset("images/logo.png",fit:BoxFit.scaleDown),
              ),
              SizedBox(height: 20), // Add space between logo and the texts
              // Container with border-radius wrapping Giriş Yap and Kayıt Ol texts with onTap functionality
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white, // Beyaz arka plan rengi
                  borderRadius:
                  BorderRadius.circular(30), // Daire şeklinde köşeler
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Giriş Yap butonu
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Navigate to Login Page
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Giriş Yap',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: customBlue, // Custom mavi metin rengi
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Ayırıcı
                      SizedBox(width: 2), // Butonlar arası boşluk
                      // Kayıt Ol butonu
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Do nothing as we are already in Register Page
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                              customBlue, // Custom mavi arka plan rengi
                              borderRadius: BorderRadius.circular(
                                  30), // Daire şeklinde köşeler
                            ),
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Metin rengi beyaz
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
    child: Column(
    children: [
    // Username TextField
    TextField(
    controller: usernameController,
    decoration: InputDecoration(
    labelText: "Kullanıcı Adı",
    hintText: "Kullanıcı adı giriniz",
    prefixIcon: Icon(Icons.person),
    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)),
    ),
    ),
    SizedBox(height: 15),
    // Email TextField
    TextField(
    controller: emailController,
    decoration: InputDecoration(
    labelText: "Email",
    hintText: "Email giriniz",
    prefixIcon: Icon(Icons.email),
    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)),
    ),
    ),
    SizedBox(height: 15),
    // Password TextField
    TextField(
    controller: passwordController,
    decoration: InputDecoration(
    labelText: "Şifre",
    hintText: "Şifre giriniz",
    prefixIcon: Icon(Icons.lock),
    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)),
    suffixIcon: IconButton(
    icon: Icon(
    _showPassword
    ? Icons.visibility
        : Icons.visibility_off,
    ),
    onPressed: () {
    setState(() {
    _showPassword = !_showPassword;
    });
    },
    ),
    ),
    obscureText: !_showPassword,
    ),
    SizedBox(height: 15),
    // Confirm Password TextField
    TextField(
    controller: confirmPasswordController,
    decoration: InputDecoration(
    labelText: "Şifreyi Onayla",
    hintText: "Şifreyi tekrar giriniz",
    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)),
    prefixIcon: Icon(Icons.lock),
    suffixIcon: IconButton(
    icon: Icon(
    _showConfirmPassword
    ? Icons.visibility
        : Icons.visibility_off,
    ),
    onPressed: () {
    setState(() {
    _showConfirmPassword = !_showConfirmPassword;
    });
    },
    ),
    ),
    obscureText: !_showConfirmPassword,
    ),
    SizedBox(height: 25),
    // Register Button
    ElevatedButton(
    onPressed: _register,
    child: Text(
    'Kayıt Ol',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Metin rengi beyaz
    ),
    ),
    style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(38, 65, 125, 1), // Butonun arka plan rengi
      minimumSize: Size(double.infinity, 50),
    ),
    ),
      ],
    ),
        ),
              ],
          ),
        ),
    );
  }
}
