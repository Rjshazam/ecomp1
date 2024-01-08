import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/LoginPage.dart';
import 'package:ecomp/Providers/AuthProvider.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    
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
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Full Name")
                            ],
                          ),
                          TextFormField(
                             controller: nameController,
                            validator: (value) {
                              if(value!.contains("!") || value.contains("*") || value.contains("@") || value.contains("\$") || value.contains("^") || value.contains("&")){
                                return "This field can not contain special characters";
                              }
                              else if(value.isEmpty){
                                return "Enter Full name";
                              }
                              else if(value.length < 4){
                                return "Enter minimum 4 characters";
                              }
                            },
                            decoration: InputDecoration(),
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
                             controller: emailController,
                            validator: (value) {
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                              if(value.isEmpty){
                                return "Enter Email";
                              }
                              else if(!emailValid){
                                return "Enter correct email";
                              }

                            },
                            keyboardType: TextInputType.emailAddress,
                           
                            decoration: InputDecoration(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Phone")
                            ],
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Phone";
                              }
                              else if(value.length < 10  || value.length > 10){
                                return "Enter 10 characters mobile number";
                              }
                            },
                            keyboardType: TextInputType.phone,
                            
                            decoration: InputDecoration(
                              prefix: Text("+91")
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
                            controller: passController,
                            validator: (value) {
                              if(value!.length < 6 || value.length > 12 ){
                                return "Enter minimum 4 and Maximum 12 characters";
                              }
                              else if(value.isEmpty){
                                return "Enter Password";
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
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
                              Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
                              GestureDetector(
                                onTap:() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Login())),
                                child: Text(" Login",style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor)))
                            ],
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              if(key.currentState!.validate()){
                              
                                final provider = Provider.of<Auth>(context,listen: false);
                                provider.createUser(emailController.text, passController.text).then((value){
                                  FirebaseFirestore.instance.collection("User").doc(emailController.text).set({
                                    'name':nameController.text,
                                    'email':emailController.text,
                                    'password':passController.text,
                                    'phone':phoneController.text
                                  }).then((value) {
                                    Get.to(Login(),transition: Transition.fade,duration: Duration(milliseconds: 400));
                                  });
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromARGB(255, 64, 89, 231)),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontFamily: "figerona",
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          
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