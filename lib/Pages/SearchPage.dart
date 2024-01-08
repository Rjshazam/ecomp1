import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Components/HomePage/ProductTile.dart';
import 'package:ecomp/Pages/DetailsPage.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Components/SearchPage/SearchedProductTile.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  String search = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            elevation: 0,
            child: TextField(          
              decoration: InputDecoration(
                border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Products..."),
              onChanged: (value) {
                setState(() {
                  search = value;
                  print(search);
                });
              },
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Products").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if(search.isEmpty){
                      return SearchProductTile(
                        data: data, 
                        price: snapshot.data.docs[index]["Price"],
                        category: snapshot.data.docs[index]["Category"],
                         description: snapshot.data.docs[index]["Dec"], 
                         image: snapshot.data.docs[index]["Image"], 
                         inStock: snapshot.data.docs[index]
                                      ["InStock"], 
                         nickname: snapshot.data.docs[index]["Nickname"],
                         title: snapshot.data.docs[index]["Title"],
                      );
                    }
                    if(data['Nickname'].toString().toLowerCase().contains(search)){
                      return SearchProductTile(
                        data: data, 
                        price: snapshot.data.docs[index]["Price"],
                        category: snapshot.data.docs[index]["Category"],
                         description: snapshot.data.docs[index]["Dec"], 
                         image: snapshot.data.docs[index]["Image"], 
                         inStock: snapshot.data.docs[index]
                                      ["InStock"], 
                         nickname: snapshot.data.docs[index]["Nickname"],
                         title: snapshot.data.docs[index]["Title"],
                      );
                    }
                    return Container(
                      // child: Image.asset("assets/saly-17.png"),
                    );
                  },
                );
              } else {
                return Text("Nothing To Show");
              }
            },
          ),
        ));
  }
}
