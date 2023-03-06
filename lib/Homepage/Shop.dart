import 'package:app/Homepage/Items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:provider/provider.dart";
import 'package:app/services/Database.dart';
import "Wishlist.dart";

class Shop extends StatefulWidget {
  final String name;
  final String image;
  final int price;
  final String productID;

  const Shop(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.productID})
      : super(key: key);
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  bool icol = false;

  Widget build(BuildContext context) {
    final user = Provider.of<String?>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              "Shop the collection",
            ),
            titleTextStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: [
              TextButton(
                child: Text("WISHLIST"),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Wishlist()));
                },
              ),
              IconButton(
                icon: (icol)
                    ? Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      )
                    : Icon(CupertinoIcons.suit_heart, color: Colors.black),
                onPressed: () {
                  setState(() {
                    icol = !icol;
                  });

                  if (Dataservice(uid: user!)
                          .isAlreadyPresent(widget.productID) ==
                      "NO") {
                    Dataservice(uid: user).wishlist(widget.productID,
                        widget.image, widget.name, widget.price);
                    print("item added to wishlist");
                  }
                },
              )
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    width: 400,
                    height: 250,
                    child: Image.asset("assets/images/" + widget.image),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black))),
                SizedBox(height: 10),
                Text(widget.name.toUpperCase(),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Rs." + "${widget.price}",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                SizedBox(
                    height: 2,
                    child: Divider(
                      color: Colors.black,
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SIZE",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: Center(
                            child: Text("SIZE GUIDE",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                )),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: SelSize(),
                ),
                SizedBox(
                    height: 2,
                    child: Divider(
                      color: Colors.black,
                    )),
                SizedBox(height: 10),
                Text("COLOR",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: SelColor(),
                ),
                SizedBox(
                    height: 2,
                    child: Divider(
                      color: Colors.black,
                    )),
                SizedBox(height: 10),
                Text("PRODUCT DETAILS",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 5),
                Text("this is product details\nproductID:#mmmm"),
                SizedBox(height: 10),
                SizedBox(
                    height: 2,
                    child: Divider(
                      color: Colors.black,
                    )),
                SizedBox(height: 10),
                Text("Shipping and Returns",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 5),
                Text(
                    "SHIPPING : delivery is expected by\nRETURN : return on this item"),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Material(
          child: TextButton(
              onPressed: () {
                print("added to cart");
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0Xffb7ea18),
                    borderRadius: BorderRadius.zero,
                    border: Border.all(
                        color: Colors.black,
                        width: 3,
                        style: BorderStyle.solid)),
                child: Center(
                  child: Text("ADD TO CART",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Color(0Xffb7ea18),
                          color: Colors.black)),
                ),
              )),
        ));
  }
}
