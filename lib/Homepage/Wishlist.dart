import 'package:app/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<String?>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Dataservice(uid: user!).wish,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? Scaffold(
                  appBar: AppBar(
                    title: Text("Wishlist"),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                  ),
                  body: ListView.separated(
                      itemBuilder: (context, index) => Container(
                          color: Colors.grey,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Center(
                                    child: Image.asset("assets/images/" +
                                        snapshot.data!.docs[index]
                                            .get("Image"))),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                              ),
                              Column(
                                children: [
                                  Text(snapshot.data!.docs[index].get("Name")),
                                  SizedBox(height: 5),
                                  Text(
                                      "${snapshot.data!.docs[index].get("Price")}"),
                                  SizedBox(height: 5),
                                  Text(
                                    snapshot.data!.docs[index].get("ProductID"),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Dataservice(uid: user).removewish(
                                            snapshot.data!.docs[index].id);
                                      },
                                      child: Text("Remove"))
                                ],
                              )
                            ],
                          )),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: snapshot.data!.docs.length),
                )
              : Container();
        });
  }
}
