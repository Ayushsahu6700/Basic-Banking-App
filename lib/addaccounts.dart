import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAccounts extends StatefulWidget {
  @override
  _AddAccountsState createState() => _AddAccountsState();
}

class _AddAccountsState extends State<AddAccounts> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var balance = 0;
  var password = "";
  final nameController = TextEditingController();
  final balanceController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  clearText() {
    nameController.clear();
    balanceController.clear();
    passwordController.clear();
  }

  CollectionReference accounts = FirebaseFirestore.instance.collection('name');
  Future<void> addUser() {
    return accounts
        .add({'name': name, 'balance': balance, 'password': password})
        .then((value) => print('User Added'))
        .catchError((error) => print('failed to add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Add New Account',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  ),
                  controller: balanceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter balance';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            balance = int.parse(balanceController.text);
                            password = passwordController.text;
                            addUser();
                            clearText();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            'Add',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        clearText();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
