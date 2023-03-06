import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "Shop.dart";

class CircleItem extends StatelessWidget {
  String name;
  String image;
  CircleItem({Key? key, required this.image, required this.name})
      : super(key: key);
  @override
  Widget build(context) {
    return SizedBox(
      height: 100,
      child: Column(children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
              //backgroundImage: AssetImage("assets/images/" + image),
              child: IconButton(
                onPressed: () {
                  print(name + " Pressed");
                },
                icon: Image.asset("assets/images/" + image,
                    width: 1000, height: 50),
              )),
        ),
        TextButton(
          child: Text(name, style: TextStyle(color: Colors.black)),
          onPressed: () {
            print(name + " pressed");
          },
        )
      ]),
    );
  }
}

class SquareItem extends StatelessWidget {
  String image;
  String name;
  int price;
  String productID;
  SquareItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.productID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Shop(
                            image: image,
                            name: name,
                            price: price,
                            productID: productID,
                          )));
              print(name + " Pressed");
            },
            child: Image.asset("assets/images/" + image)),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
        ));
  }
}

class SelSize extends StatefulWidget {
  const SelSize({Key? key}) : super(key: key);
  _SelSizeState createState() => _SelSizeState();
}

class _SelSizeState extends State<SelSize> {
  @override
  List<bool> isSelected = [true, false, false, false, false, false, false];
  Widget build(BuildContext context) {
    List<int> size = [28, 30, 32, 34, 36, 38, 40];
    return GridView.builder(
        itemCount: 7,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (context, index) {
          return TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
            child: (isSelected[index])
                ? CircleAvatar(
                    backgroundColor: Color(0xffbcbbbb),
                    radius: 20,
                    child: Text("${size[index]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)))
                : Text("${size[index]}", style: TextStyle(color: Colors.black)),
            onPressed: () {
              for (int i = 0; i < size.length; i++) {
                if (isSelected[i] == true) {
                  setState(() {
                    isSelected[i] = false;
                  });
                }
              }
              setState(() {
                isSelected[index] = true;
              });
            },
          );
        });
  }
}

class SelColor extends StatefulWidget {
  const SelColor({Key? key}) : super(key: key);
  _SelColorState createState() => _SelColorState();
}

class _SelColorState extends State<SelColor> {
  @override
  List<bool> isSelected = [false, false, false, false];
  Widget build(BuildContext context) {
    List<Color> color = [Colors.grey, Colors.black, Colors.white, Colors.green];
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent)),
              onPressed: () {
                for (int i = 0; i < 4; i++) {
                  if (isSelected[i]) {
                    setState(() {
                      isSelected[i] = false;
                    });
                  }
                }
                setState(() {
                  isSelected[index] = true;
                });
              },
              child: (isSelected[index])
                  ? CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: color[index],
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 18,
                      backgroundColor: color[index],
                    ));
        });
  }
}
