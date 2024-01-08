

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/CheckOutPage.dart';
import 'package:ecomp/Pages/HomePage.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
       appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
       ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .doc(
                            FirebaseAuth.instance.currentUser!.email.toString())
                        .collection("Cart")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length != 0) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                int qty = int.parse(snapshot
                                    .data.docs[index]["Quantity"]
                                    .toString());
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 120,
                                            child: Image.network(snapshot
                                                .data.docs[index]["Image"]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                        ["Nickname"],
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: "figerona"),
                                                  ),
                                                ),
                                                Text(
                                                  "Rs:${snapshot.data.docs[index]["Price"]}",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontFamily: "figerona",
                                                      color: primaryColor),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Quantity: ",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (qty != 1) {
                                                                setState(() {
                                                                  qty = (qty - 1);
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "User")
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .email)
                                                                      .collection(
                                                                          "Cart")
                                                                      .doc(snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              "Title"]
                                                                          .toString())
                                                                      .update({
                                                                    "Quantity": qty
                                                                        .toString()
                                                                  });
                                                                });
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        135,
                                                                        198,
                                                                        250),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Icon(
                                                              Icons.remove,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ["Quantity"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (qty != 10) {
                                                                setState(() {
                                                                  qty = (qty + 1);
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "User")
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .email)
                                                                      .collection(
                                                                          "Cart")
                                                                      .doc(snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              "Title"]
                                                                          .toString())
                                                                      .update({
                                                                    "Quantity": qty
                                                                        .toString()
                                                                  });
                                                                });
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        135,
                                                                        198,
                                                                        250),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    height: 220,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.delete_outline,
                                                          size: 80,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Do you want to remove this item from your cart.",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            184,
                                                                            219,
                                                                            247)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text("No")),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            251,
                                                                            183,
                                                                            178)),
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "User")
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .email)
                                                                      .collection(
                                                                          "Cart")
                                                                      .doc(snapshot
                                                                              .data
                                                                              .docs[index]
                                                                          [
                                                                          "Title"])
                                                                      .delete().then((value) => Navigator.pop(context));
                                                                },
                                                                child: Text(
                                                                  "Yes",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/saly-11.png"),
                                  Text("No items in cart",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "figerona",fontSize: 20),),
                                 
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage())),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 70,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color:
                                                Color.fromARGB(255, 64, 89, 231)),
                                        child: Text(
                                          "Start Shopping",
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
                          );
                        }
                      } else {
                        return Center(child: Text("Nothing to Show"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            color: Colors.transparent,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('User')
                          .doc(FirebaseAuth.instance.currentUser!.email
                              .toString())
                          .collection('Cart')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          int total = 0;
                          snapshot.data!.docs.forEach((result) {
                            total += int.parse(result['Price']) *
                                int.parse(result['Quantity']);
                          });
                          if(total != 0){
                            return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontFamily: "figerona"),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Rs.${total.toString()}',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontFamily: "figerona"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 70,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color:
                                              Color.fromARGB(255, 64, 89, 231)),
                                      child: Text(
                                        "Checkout",
                                        style: TextStyle(
                                            fontFamily: "figerona",
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }
                          else{
                            return Container();
                          }
                        }
                      }),
                )
              ]),
            ),
          ),
        ));
  }
}
