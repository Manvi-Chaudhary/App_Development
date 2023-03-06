import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/services/Authentication.dart';
import 'Items.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    List<String> image = [
      "sneakers.PNG",
      "t-shirts.PNG",
      "bags.PNG",
      "Heels.PNG",
      "jackets.PNG",
      "sunglasses.PNG"
    ];
    List<String> image_g = ["t-shirts.PNG", "jackets.PNG"];
    List<String> name_g = ["T-shirts", "Jackets"];
    List<String> name = [
      "Sneakers",
      "T-shirts",
      "Bags",
      "Heels",
      "Jackets",
      "Sunglasses"
    ];
    List<String> productID = [
      "1007128-1A05134_1E51V",
      "1007128-1A05134_1E52V",
      "1007128-1A05134_1E53V",
      "1007128-1A05134_1E54V",
      "1007128-1A05134_1E55V",
      "1007128-1A05134_1E56V"
    ];
    List<int> price = [8, 10, 2, 6, 12, 4];
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("VERSACE",
              style: TextStyle(
                  letterSpacing: 4, fontSize: 20, fontWeight: FontWeight.w600)),
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
                child: Text("sign out"),
                onPressed: () async {
                  await Authservice().signout();
                })
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView(children: [
                  CarouselSlider.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/v_c${index + 1}.PNG"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  )
                ]),
              ),
              SizedBox(height: 10),
              Text("VERSACE NEW CAMPAIGN SPRING 2022",
                  style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 5),
              Text(
                  "A new installment of versace's multi-phase\ncampaign photographed by Stef Mitchell will be\nreleaded in several waves"),
              SizedBox(height: 20),
              SizedBox(
                height: 90,
                child: ListView.separated(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) =>
                        CircleItem(image: image[index], name: name[index])),
              ),
              SizedBox(height: 10),
              Text("SHOP THE COLLECTION /",
                  style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              SizedBox(
                height: 500,
                child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5),
                    itemBuilder: (context, index) => SquareItem(
                        image: image[index],
                        name: name[index],
                        price: price[index],
                        productID: productID[index])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
