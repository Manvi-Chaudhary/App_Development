import "package:flutter/material.dart";

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "SHOPPING BAG",
          ),
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [],
        ));
  }
}
