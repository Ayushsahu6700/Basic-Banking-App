import 'package:banking/account_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TransferMoney extends StatefulWidget {
  final String id1;
  final String name1;
  final dynamic bal1;
  final String name2;
  final dynamic bal2;
  final String id2;
  TransferMoney(
      {Key? key,
      required this.id1,
      required this.name1,
      required this.bal1,
      required this.id2,
      required this.name2,
      required this.bal2})
      : super(key: key);
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference accounts = FirebaseFirestore.instance.collection('name');
  Future<void> transfer(id, name, balance, password) {
    return accounts.doc(id).update({
      'name': name,
      'balance': balance,
      'password': password
    }).catchError((error) => print("Failed to update user:$error"));
    print('money transfered');
  }

  TextEditingController amountcontroller = TextEditingController();
  var trans = 0;
  var alertStyle = AlertStyle(
    animationType: AnimationType.shrink,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.center,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      fontSize: 30.0,
      color: Colors.indigo,
      letterSpacing: 2,
      fontFamily: 'Pacifico',
      fontWeight: FontWeight.w900,
    ),
    alertAlignment: Alignment.bottomCenter,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Transfer Money To',
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    // /BoxShadow
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name1,
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 45.0,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      ' >> ',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 45.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      widget.name2,
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 45.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Current Balance: ",
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 40.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.bal1.toString(),
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 40.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: amountcontroller,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) => trans = int.parse(value),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Transfer",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("name")
                      .doc(widget.id1)
                      .update({"balance": widget.bal1 - trans});
                  FirebaseFirestore.instance
                      .collection("name")
                      .doc(widget.id2)
                      .update({"balance": widget.bal2 + trans});
                  print(trans);
                  Alert(
                      context: context,
                      style: alertStyle,
                      title: "TRANSACTION SUCCESSFUL",
                      image: Image.asset("images/success2.jpg"),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Accounts(),
                                ));
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
              )
            ],
          ),
        ));
  }
}
// Form(
// key: _formKey,
// child: FutureBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
// future: FirebaseFirestore.instance
//     .collection('name')
// .doc(widget.id1)
// .get(),
// builder: (_, snapshot) {
// if (snapshot.hasError) {
// print('Something went wrong');
// }
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Center(
// child: CircularProgressIndicator(),
// );
// }
// var data = snapshot.data!.data();
// var name = data!['name'];
// var balance = data['balance'];
// var password = data['password'];
// return Padding(
// padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
// child: ListView(
// children: [
// Container(
// margin: EdgeInsets.symmetric(vertical: 10.0),
// child: TextFormField(
// initialValue: name,
// autofocus: false,
// onChanged: (value) => name = value,
// decoration: InputDecoration(
// labelText: 'Name',
// labelStyle: TextStyle(fontSize: 20.0),
// border: OutlineInputBorder(),
// errorStyle:
// TextStyle(color: Colors.redAccent, fontSize: 15.0),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please Enter Name';
// }
// return null;
// },
// ),
// ),
// Container(
// margin: EdgeInsets.symmetric(vertical: 10.0),
// child: TextFormField(
// autofocus: false,
// onChanged: (value) => balance = value,
// initialValue: balance,
// decoration: InputDecoration(
// labelText: 'Amount',
// labelStyle: TextStyle(fontSize: 20.0),
// border: OutlineInputBorder(),
// errorStyle:
// TextStyle(color: Colors.redAccent, fontSize: 15.0),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please Enter balance';
// }
// return null;
// },
// ),
// ),
// Container(
// margin: EdgeInsets.symmetric(vertical: 10.0),
// child: TextFormField(
// initialValue: password,
// autofocus: false,
// onChanged: (value) => password = value,
// obscureText: true,
// decoration: InputDecoration(
// labelText: 'Password',
// labelStyle: TextStyle(fontSize: 20.0),
// border: OutlineInputBorder(),
// errorStyle:
// TextStyle(color: Colors.redAccent, fontSize: 15.0),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please Enter Password';
// }
// return null;
// },
// ),
// ),
// Container(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ElevatedButton(
// style:
// ElevatedButton.styleFrom(primary: Colors.indigo),
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// transfer(widget.id1, name, balance, password);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Accounts(),
// ));
// }
// print(widget.id1);
// print(widget.name1);
// print(widget.bal1);
// print(widget.id2);
// print(widget.name2);
// print(widget.bal2);
// },
// child: Row(
// children: [
// Text(
// 'Transfer',
// style: TextStyle(fontSize: 20.0),
// ),
// Icon(Icons.play_arrow),
// ],
// ),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(primary: Colors.red),
// onPressed: () {},
// child: Text(
// 'Reset',
// style: TextStyle(fontSize: 20.0),
// ),
// )
// ],
// ),
// )
// ],
// ),
// );
// },
// ),
// ),
