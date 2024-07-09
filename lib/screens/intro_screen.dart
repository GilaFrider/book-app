import 'package:book_app/model/model.dart';
import 'package:book_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget{
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;
  IntroScreen({
    required this.toggleDarkMode,
    required this.isDarkMode
    });
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(isDarkMode? Icons.dark_mode : Icons.light_mode),
              onPressed: toggleDarkMode,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Welcome to Book App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 20,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context,index){
                    final book = books[index];
                    return GridTile(
                      child:Image.asset(book.imageURL,fit: BoxFit.cover),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(
                          book.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                      ),
                      )
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        isDarkMode: isDarkMode,
                        toggleDarkMode: toggleDarkMode,
                      ),
                    ),
                  );
                },
                child: Text("Home Page"),
              ),
              
            ],
          ),
        ),
      );

  }
}
