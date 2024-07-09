import 'package:book_app/model/model.dart';
import 'package:book_app/screens/intro_screen.dart';
import 'package:book_app/screens/register_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;

  LoginScreen({
    required this.toggleDarkMode,
    required this.isDarkMode,
  });

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IntroScreen(
            toggleDarkMode: widget.toggleDarkMode,
            isDarkMode: widget.isDarkMode,
          ),
        ),
      );
    }catch(e) {
      print('Login Failed : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Failed"),
        ),
      );
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBookCarousel(),
            SizedBox(height: 20,),
            _buildTextField(userNameController, "User Name"),
            SizedBox(height: 10,),
            _buildTextField(passwordController, "Password",obscureText: true),
            SizedBox(height: 10,),
            ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IntroScreen(
                    toggleDarkMode: widget.toggleDarkMode,
                    isDarkMode: widget.isDarkMode,
                  ),
                ),
              );
            },
            child: Text('Login'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(
                        toggleDarkMode: widget.toggleDarkMode,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                  );
                },
                child: Text('Dont have an acount? Register'),
              )
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(TextEditingController controller,
   String labelText, {bool obscureText = false})
   {
     return TextField(
       controller: controller,
       obscureText: obscureText,
       decoration: InputDecoration(
         labelText: labelText,
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
         ),
       ),
     );
   
  }
  Widget _buildBookCarousel(){
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context,index,child){
        final book = books[index];
        return _buildBookItem(book);
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
        autoPlayInterval: Duration(seconds: 3)
      ),
    );
  }
  Widget _buildBookItem(Book book){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}