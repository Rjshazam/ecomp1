import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SavedProductsPage extends StatefulWidget {
  SavedProductsPage({Key? key}) : super(key: key);

  @override
  State<SavedProductsPage> createState() => _SavedProductsPageState();
}

class _SavedProductsPageState extends State<SavedProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .doc(
                            FirebaseAuth.instance.currentUser!.email.toString())
                        .collection("Saved")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length != 0) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: 150,
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
                                              Text(
                                                snapshot.data.docs[index]
                                                    ["Nickname"],
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: "figerona"),
                                              ),
                                              SizedBox(height: 15,),
                                              Text(
                                                "Rs:${snapshot.data.docs[index]["Price"]}",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: "figerona",
                                                    color: primaryColor),
                                              ),
                                             
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IconButton(onPressed: (){
                                  FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Saved").doc(snapshot.data.docs[index]["Title"]).delete();
                                 }, icon: Icon(Icons.favorite))
                                ],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No Saved items?",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "figerona",fontSize: 20),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
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
    );
  }
}