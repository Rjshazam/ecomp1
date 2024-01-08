import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoGoogle extends StatefulWidget {
  InfoGoogle({Key? key}) : super(key: key);

  @override
  State<InfoGoogle> createState() => _InfoGoogleState();
}

class _InfoGoogleState extends State<InfoGoogle> {
   final key = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController();
    // TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    // TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Information"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Column(
              children: [
                Text(FirebaseAuth.instance.currentUser!.displayName.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}