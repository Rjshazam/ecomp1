import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Components/SearchPage/SearchedProductTile.dart';

class Categorywise extends StatefulWidget {
  final String category;
  const Categorywise({Key? key, required this.category}) : super(key: key);

  @override
  State<Categorywise> createState() => _CategorywiseState();
}

class _CategorywiseState extends State<Categorywise> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.category),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                color: Colors.white,
                // elevation: 0,
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
            ),
            SizedBox(height: 50,),
            Container(
              
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Products").where("Category",isEqualTo: widget.category).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
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
                        return Container();
                      },
                    );
                    
                  }
                  else{
                    return Text("");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}