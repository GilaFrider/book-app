import 'package:book_app/model/model.dart';
import 'package:book_app/screens/intro_screen.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class RegisterScreen extends StatefulWidget{
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;
  RegisterScreen({
    required this.toggleDarkMode,
    required this.isDarkMode
     });
    
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final TextEditingController userNameController = TextEditingController();
void _register() async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailNameController.text.trim(),
        password: passwordController.text.trim(),
        
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroScreen(
              toggleDarkMode: widget.toggleDarkMode,
              isDarkMode: widget.isDarkMode,
            ),
          )
        );

    }catch(e){
      print('Registration failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed'),
        ),
      );

    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
             _buildBookCarousel(),
            SizedBox(height: 20,),
            _buildTextField(userNameController, 'Username'),
            SizedBox(height: 10),
            _buildTextField(emailNameController, 'Email'),
            SizedBox(height: 10),
            _buildTextField(passwordController, 'Password', obscureText: true),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _register,
              
              child: Text('Register'),
            ),
          ],
        ) ,
        
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