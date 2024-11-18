import 'package:ems_pro_max/auth.dart';
import 'package:ems_pro_max/constants/colors.dart';
import 'package:ems_pro_max/saved_data.dart';
import 'package:ems_pro_max/views/login.dart';
import 'package:ems_pro_max/views/manage_events.dart';
import 'package:ems_pro_max/views/rsvp_events.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    name = SavedData.getUserName();
    email = SavedData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: kLightGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 24)),
                Text(
                  email,
                  style: TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RSVPEvents())),
                    title: Text("RSVP Events",
                        style: TextStyle(color: kLightGreen)),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageEvents())),
                    title: Text("Manage Events",
                        style: TextStyle(color: kLightGreen)),
                  ),
                  ListTile(
                    onTap: () {
                      logoutUser();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    title: Text(
                      "Logout",
                      style: TextStyle(color: kLightGreen),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
