import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/custom_appbar.dart';
import 'package:untitled/custom_textfield.dart';
import 'register.dart'; // Assuming you have a RegisterPage defined in register.dart
import 'home.dart'; // Assuming you have a HomePage defined in homepage.dart
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkAuthAndNavigate();
    });
  }

  void checkAuthAndNavigate() {
    User? user = _auth.currentUser;
    if (user != null) {
      // If the user is already signed in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // User successfully signed in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      print('Signed in user: ${userCredential.user!.uid}');
    } catch (e) {
      // Error signing in
      print('Error signing in: $e');
      // Show SnackBar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş yaparken bir hata oluştu: $e'),
          duration: Duration(
              seconds: 3), // SnackBar'ın ne kadar süreyle görüntüleneceği
        ),
      );
    }
  }
  final Color customBlue = Color.fromRGBO(38, 65, 125, 1);
  @override
  Widget build(BuildContext context) {
    // Define the custom blue color



    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 190,
                    height: 190,
                    child:
                        Image.asset("images/logo.png", fit: BoxFit.scaleDown),
                  ),
                  SizedBox(height: 20), // Add space between logo and the texts
                  // Container with border-radius wrapping Giriş Yap and Kayıt Ol texts with onTap functionality
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70, // Beyaz arka plan rengi
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage()), // Assuming LoginPage exists
                                );
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
                                  'Giriş Yap',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Metin rengi beyaz
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
                                // Navigate to Register Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage()), // Assuming RegisterPage exists
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Kayıt Ol',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        customBlue, // Custom mavi metin rengi
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: Column(
                children: [
                  // Email TextField
                  CustomTextField(textController: emailController, myIcon: Icon(Icons.mail,color:customBlue,), labelText: "Mail", hintText: "mail@example.com"),
                  SizedBox(height: 25),
                  // Password TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Email giriniz",
                    prefixIcon: Icon(Icons.lock),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color:Color.fromRGBO(38, 65, 125, 1))),
                  ),
                ),
                  SizedBox(height: 40),
                  // Sign In Button
                  ElevatedButton(
                    onPressed: _signInWithEmailAndPassword,
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Metin rengi beyaz
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          38, 65, 125, 1), // Butonun arka plan rengi
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
