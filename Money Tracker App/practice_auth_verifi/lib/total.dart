// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:practiceauthverifi/datamodel.dart';
import 'datalist.dart';
import 'package:provider/provider.dart';

class Total extends StatefulWidget {
  const Total({Key? key}) : super(key: key);
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  Widget build(BuildContext context) {
    int ttrgive = 0;
    int tfagive = 0;
    final dati = Provider.of<List<Datamodel>>(context);
    dati.forEach((element) {
      if (element.give!) {
        setState(() {
          ttrgive = ttrgive + element.amount!;
        });
      } else {
        setState(() {
          tfagive = tfagive + element.amount!;
        });
      }
    });
    return Container(
        //padding: EdgeInsets.all(10),
        color: Color(0xff283be7),
        child: Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${tfagive}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        )),
                    Text(
                      'You will get',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  height: 40,
                  width: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${ttrgive}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffd2281c),
                      ),
                    ),
                    Text(
                      'You will give',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
