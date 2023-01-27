import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'usermodel.dart';
import 'package:provider/provider.dart';
import 'package:practiceauthverifi/services/database.dart';

class Updateform extends StatefulWidget {
  final String? did;
  const Updateform({Key? key, this.did}) : super(key: key);
  _UpdateformState createState() => _UpdateformState();
}

class _UpdateformState extends State<Updateform> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool load = false;
  String name1 = '';
  int amount1 = 0;
  @override
  final List<bool> _selected = <bool>[true, false];
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    List<Widget> l1 = [Text('You will get'), Text('You will give')];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
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
                      constraints: BoxConstraints(
                        minHeight: 30.0,
                        minWidth: 100.0,
                      ),
                      isSelected: _selected,
                      children: l1,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff283be7))),
                          icon: Icon(
                            Icons.person,
                            color: Color(0xff283be7),
                          ),
                          hintText: 'Enter Name',
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Color(0xff283be7))),
                      onChanged: (value) {
                        setState(() {
                          name1 = value;
                        });
                      },
                      validator: (value) {
                        (value!.isEmpty) ? 'Enter a valid name' : null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff283be7))),
                          icon: FaIcon(
                            FontAwesomeIcons.moneyBill,
                            color: Color(0xff283be7),
                          ),
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
                          await DatabaseService(uid: user!.uid, did: widget.did)
                              .field(name1, amount1, _selected[1]);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff283be7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Update',
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
