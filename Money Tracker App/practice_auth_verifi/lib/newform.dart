import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:practiceauthverifi/loading.dart';
import 'usermodel.dart';
import 'package:provider/provider.dart';
import 'package:practiceauthverifi/services/database.dart';

class Newform extends StatefulWidget {
  const Newform({Key? key}) : super(key: key);
  _NewformState createState() => _NewformState();
}

class _NewformState extends State<Newform> {
  String name1 = '';
  int amount1 = 0;
  final List<bool> _selected = <bool>[true, false];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<Widget> l1 = [Text('You will get'), Text('You will give')];
    bool load = false;
    final user = Provider.of<TheUser?>(context);
    if (load) {
      return Loading();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Customer'),
        backgroundColor: Color(0xff283be7),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _selected.length; i++) {
                            _selected[i] = i == index;
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Color(0xff283be7),
                      selectedColor: Colors.white,
                      fillColor: Color(0xff283be7),
                      color: Color(0xff283be7),
                      constraints: const BoxConstraints(
                        minHeight: 30.0,
                        minWidth: 100.0,
                      ),
                      isSelected: _selected,
                      children: l1,
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Color(0xff283be7)),
                          hintText: 'Enter Name',
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Color(0xff283be7)),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff283be7))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            name1 = value;
                          });
                        },
                        validator: (value) {
                          (value!.isEmpty) ? 'Enter a valid name' : null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff283be7))),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          icon: FaIcon(FontAwesomeIcons.moneyBill,
                              color: Color(0xff283be7)),
                          hintText: 'Enter Amount',
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Color(0xff283be7))),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          amount1 = int.parse(value);
                        });
                      },
                      validator: (value) {
                        (value.runtimeType != int ||
                                value.runtimeType != double)
                            ? 'Enter a valid amount '
                            : null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            load = true;
                          });

                          await DatabaseService(uid: user!.uid)
                              .field(name1, amount1, _selected[1]);
                          setState(() {
                            load = false;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color(0xff283be7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
