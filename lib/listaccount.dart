import 'package:banking/account_holder.dart';
import 'package:banking/selectaccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListAccounts extends StatefulWidget {
  @override
  _ListAccountsState createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  final Stream<QuerySnapshot> accountStream =
      FirebaseFirestore.instance.collection('name').snapshots();
  CollectionReference accounts = FirebaseFirestore.instance.collection('name');
  Future<void> deleteUser(id) {
    return accounts
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('failed to delete user: $error'));
  }

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
      fontFamily: 'SourceSansPro',
      fontWeight: FontWeight.w900,
    ),
    alertAlignment: Alignment.center,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: accountStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<dynamic, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                )
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(color: Colors.indigo),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          'Balance ₹',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                          child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            storedocs[i]['name'],
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            storedocs[i]['balance'].toString(),
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                      TableCell(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectAccounts(
                                          id1: storedocs[i]['id'],
                                          name1: storedocs[i]['name'],
                                          bal1: storedocs[i]['balance'],
                                        ),
                                      ),
                                    )
                                  },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                deleteUser(storedocs[i]['id']);
                                Alert(
                                    context: context,
                                    style: alertStyle,
                                    title: "Acount Deleted",
                                    image: Image.asset("images/deleted.png"),
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Accounts(),
                                              ));
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]).show();
                              },
                              icon: Icon(Icons.delete, color: Colors.red)),
                        ],
                      ))
                    ]),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
