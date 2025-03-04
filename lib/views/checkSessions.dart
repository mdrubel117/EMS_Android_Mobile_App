import 'package:ems_pro_max/auth.dart';
import 'package:ems_pro_max/views/homepage.dart';
import 'package:ems_pro_max/views/login.dart';
import 'package:flutter/material.dart';

class CheckSessions extends StatefulWidget {
  const CheckSessions({super.key});

  @override
  State<CheckSessions> createState() => _CheckSessionsState();
}

class _CheckSessionsState extends State<CheckSessions> {
  @override
  void initState() {
    checkSessions().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
