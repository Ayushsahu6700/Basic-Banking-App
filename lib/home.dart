import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'account_holder.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/banklogo.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TSF",
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 45.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "BANK",
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 45.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            TyperAnimatedTextKit(
              text: ["A Basic Banking App"],
              speed: Duration(milliseconds: 100),
              textStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.green[700],
                letterSpacing: 3,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: Divider(
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Accounts();
                }));
              },
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Account Names",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_right_rounded,
                        size: 50,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
