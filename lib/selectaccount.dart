import 'package:banking/transfermoney.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectAccounts extends StatefulWidget {
  final String id1;
  final String name1;
  final dynamic bal1;
  SelectAccounts(
      {Key? key, required this.id1, required this.name1, required this.bal1})
      : super(key: key);
  @override
  _SelectAccountsState createState() => _SelectAccountsState();
}

class _SelectAccountsState extends State<SelectAccounts> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black26,
        title: Center(
          child: Text(
            "Select Account",
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              fontSize: 35.0,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: accountStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            'Select',
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
                                      if (storedocs[i]['id'] != widget.id1)
                                        {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TransferMoney(
                                                      id1: widget.id1,
                                                      name1: widget.name1,
                                                      bal1: widget.bal1,
                                                      id2: storedocs[i]['id'],
                                                      name2: storedocs[i]
                                                          ['name'],
                                                      bal2: storedocs[i]
                                                          ['balance']),
                                            ),
                                          )
                                        }
                                    },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.green,
                                )),
                          ],
                        ))
                      ]),
                    ],
                  ],
                ),
              ),
            );
          }),
    );
  }
}
