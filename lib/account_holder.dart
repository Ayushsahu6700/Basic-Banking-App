import 'package:banking/listaccount.dart';
import 'package:flutter/material.dart';

import 'addaccounts.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Account Names",
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddAccounts();
                }));
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 20.0),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
            ),
          ],
        ),
      ),
      body: ListAccounts(),
    );
  }
}
