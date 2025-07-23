
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';



class SpleshScreen extends StatefulWidget {
  @override
  _SpleshScreenState createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      Future.delayed(
        const Duration(seconds: 2),
      ),
     ]).then((value) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text("PAŞA PROJECT",
            style: TextStyle(
              color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}
