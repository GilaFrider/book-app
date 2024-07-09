//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:book_app/main.dart';
import 'package:book_app/model/model.dart';
import 'package:book_app/screens/payment_page.dart';
import 'package:flutter/material.dart';
//import 'dart:core' as core;

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeFromCart(Book book) {
    setState(() {
      cart.remove(book);
    });
  }

  void _clearCart() {
    setState(() {
      cart.clear();
    });
  }

double _calculateTotalPrice() {
  double totalPrice = 0.0;
  for (var book in cart) {
    totalPrice += book.price;
  }
  return totalPrice;
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart"),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text("Your cart is empty"),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final book = cart[index];
                    return ListTile(
                        leading: Image.asset(book.imageURL),
                        title: Text(book.title),
                        subtitle: Text('\$' + '${book.price}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _removeFromCart(book),
                        ));
                  },
                )),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        "Total: \$${_calculateTotalPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPage(
                                      onPaymentSuccess: _clearCart)));
                        },
                        child: Text("Pay Now"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
