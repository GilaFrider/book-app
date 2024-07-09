import 'package:book_app/main.dart';
import 'package:book_app/model/model.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget{
  final Book book;
  BookDetails({
    required this.book
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left:25,right:25,bottom: 25,top: 50),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 55,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15), 
                    ),
                    child: Icon(Icons.keyboard_arrow_left,size: 25,
                    color: Colors.black,),
                  ),
                ),
                
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 300,
              child: Hero(
                tag:book.imageURL,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(book.imageURL)
                  ),
                ),
              ),
            ),
          SizedBox( height: 30,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      book.author,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      '\$'+'${book.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                    //SizedBox(height: 15,),
                    Text(
                      "Book Description",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      book.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        height: 1.5
                      ),
                    ),
                    SizedBox(height: 5,),
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          cart.add(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Book Added to Cart"),
                            ),
                          );
                        },
                        child: Text("Add Cart"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}