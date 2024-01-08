import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   
  String? email;
  String? phone;
  String? name;
  String? address;
  // getData(){
  //   FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).get().then((value) {
  //     setState(() {
  //       email= value["email"];
  //       // phone= value["phone"];
  //       name= value["name"];
  //     });
  //   });
  //   FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Shipping").doc("1").get().then((value) {
  //     setState(() {
  //       address=value["Address"];
  //     });
  //   });
  // }
 
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressConrtroller = TextEditingController();
    final key = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "My Profile",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 220,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 52),
                            child: Column(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("User")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data["name"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: "figerona"));
                                    } else {
                                      return Text("");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("User")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("Shipping")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.docs.length != 0) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on_outlined,size: 40,),
                                              SizedBox(width: 10,),
                                              Expanded(child: Text(snapshot.data.docs[0]["Address"],style: TextStyle(fontSize: 17),)),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    children: [
                                                      SizedBox(
                                                        // height: 400,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 10),
                                                          child: Form(
                                                            key: key,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                    "Add Information",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        nameController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Enter Full Name";
                                                                      }
                                                                    },
                                                                    decoration: const InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        hintText:
                                                                            "Enter Full Name",
                                                                        prefixIcon:
                                                                            Icon(Icons
                                                                                .person),
                                                                        label: Text(
                                                                            "Name")),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        addressConrtroller,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Enter Address";
                                                                      }
                                                                    },
                                                                    decoration: const InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        hintText:
                                                                            "Enter Address",
                                                                        prefixIcon:
                                                                            Icon(Icons
                                                                                .home),
                                                                        label: Text(
                                                                            "Address")),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        phoneController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Enter Phone Number";
                                                                      }
                                                                    },
                                                                    decoration: const InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        hintText:
                                                                            "Enter Phone Number",
                                                                        prefixIcon:
                                                                            Icon(Icons
                                                                                .phone),
                                                                        label: Text(
                                                                            "Phone")),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      if (key
                                                                          .currentState!
                                                                          .validate()) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "User")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser!.email)
                                                                            .collection(
                                                                                "Shipping")
                                                                            .doc(
                                                                                "1")
                                                                            .set({
                                                                          "Name":
                                                                              nameController.text,
                                                                          "Address":
                                                                              addressConrtroller.text,
                                                                          "Phone":
                                                                              phoneController.text
                                                                        }).then((value) =>
                                                                                Navigator.pop(context));
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          70,
                                                                      width:
                                                                          300,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15),
                                                                          color: const Color.fromARGB(
                                                                              255,
                                                                              64,
                                                                              89,
                                                                              231)),
                                                                      child:
                                                                          const Text(
                                                                        "Continue",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "figerona",
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Add Infromation"));
                                      }
                                    } else {
                                      return Text("");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 120,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                    .collection("User")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              return FirebaseAuth.instance.currentUser!.photoURL
                                      .toString() ==
                                  "null"
                              ? Container(
                                alignment: Alignment.center,
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    snapshot.data["name"]
                                        .toString()
                                        .toUpperCase()
                                        .substring(0, 1),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                        color: Colors.white),
                                  ),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(FirebaseAuth
                                              .instance.currentUser!.photoURL
                                              .toString()))),
                                );
                            }
                            else{
                              return Text("");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              size: 32,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Shipping Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              size: 32,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Order History",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              size: 32,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Cards",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              size: 32,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              size: 32,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
