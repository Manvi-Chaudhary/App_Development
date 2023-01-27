import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practiceauthverifi/services/database.dart';
import 'datamodel.dart';
import 'updateform.dart';
import 'dart:math';

class Datalist extends StatefulWidget {
  final String? uid;

  const Datalist({Key? key, this.uid}) : super(key: key);
  _DatalistState createState() => _DatalistState();
}

class _DatalistState extends State<Datalist> {
  @override
  Widget build(BuildContext context) {
    bool newi = false;
    Widget check(String str) {
      if (str == "") {
        return Text('P',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400));
      }
      return Text(str[0].toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400));
    }

    List<Color> col = [
      Colors.blue,
      Colors.amber,
      Colors.deepOrange,
      Colors.green,
      Colors.indigo
    ];

    return StreamBuilder<List<Datamodel>>(
        stream: DatabaseService(uid: widget.uid).data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Datamodel> datas = snapshot.data!;

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return Card(
                        borderOnForeground: true,
                        margin: EdgeInsets.all(10),
                        child: SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                child: check(datas[index].name!),
                                backgroundColor:
                                    col[Random().nextInt(col.length)],
                                radius: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${datas[index].name}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${datas[index].date!.day}/${datas[index].date!.month}/${datas[index].date!.year}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text("${datas[index].amount}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: (datas[index].give!)
                                        ? Colors.red
                                        : Colors.green,
                                  )),
                              Row(children: [
                                TextButton.icon(
                                  onPressed: (() async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Updateform(
                                                did: datas[index].doc_id)));
                                  }),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color(0xff283be7),
                                  ),
                                  label: Text(""),
                                ),
                                TextButton.icon(
                                  onPressed: (() async {
                                    dynamic res = await DatabaseService(
                                            uid: widget.uid,
                                            did: datas[index].doc_id)
                                        .deleteform(datas[index].doc_id);
                                  }),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0xff283be7),
                                  ),
                                  label: Text(""),
                                )
                              ]),
                            ],
                          ),
                        ));
                  },
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        });
  }
}
