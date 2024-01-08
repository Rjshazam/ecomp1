

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/HomePage.dart';
import 'package:ecomp/Pages/InfoGoogle.dart';
import 'package:ecomp/Pages/RegisterPage.dart';
import 'package:ecomp/Providers/AuthProvider.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final key = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    
    bool isVisible = false;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 64, 89, 231),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'figerona'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Back",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'figerona'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Form(
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Icon(Icons.email_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Email")
                            ],
                          ),
                          TextFormField(
                            validator: (value) {
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                              if(value.isEmpty){
                                return "Enter Email";
                              }
                              else if(!emailValid){
                                return "Enter correct email";
                              }},
                            controller: emailController,
                            decoration: InputDecoration(),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            children: [
                              Icon(Icons.lock_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Password")
                            ],
                          ),
                          TextFormField(
                            validator: (value) {
                              if(value!.length < 6 || value.length > 12 ){
                                return "Enter minimum 4 and Maximum 12 characters";
                              }
                              else if(value.isEmpty){
                                return "Enter Password";
                              }
                            },
                            controller: passController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                              onPressed: () {
                                
                              },
                              icon: Icon(Icons.remove_red_eye_outlined),
                            )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Forgot Password?",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 64, 89, 231),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: GestureDetector(
                              onTap: () {
                               
                                  if(key.currentState!.validate()){
                                  final provider = Provider.of<Auth>(context,listen: false);
                                  provider.loginUser(emailController.text, passController.text).then((value) {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Main()));
                                  });
                                  }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromARGB(255, 64, 89, 231)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "figerona",
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: primaryColor,
                                onTap: () {
                                  Get.to(RegisterPage(),transition: Transition.fade,duration: Duration(milliseconds: 400));
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 64, 89, 231),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("OR"),
                            ],
                          ),
                          Divider(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                   final provider = Provider.of<Auth>(context,listen: false);
                                   provider.signInWithGoogle().then((value) {
                                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>InfoGoogle()));
                                      FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).set({
                                        "name": FirebaseAuth.instance.currentUser!.displayName.toString(),
                                        "email":FirebaseAuth.instance.currentUser!.email.toString()
                                      }).then((value) {
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Main()));
                                      });
                                   });
                                },
                                child: Container(
                                  height: 50,
                                  
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(1.0,
                                              1.0), // shadow direction: bottom right
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(FontAwesomeIcons.google,color: Colors.red,),
                                            SizedBox(width: 10,),
                                            Text("Signin with Google",style: TextStyle(color: Color.fromARGB(255, 64, 89, 231),fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
