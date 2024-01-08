import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/Categorywise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreCat extends StatelessWidget {
  const MoreCat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Category").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () => Get.to(Categorywise(category: snapshot.data.docs[index]["Category"]),transition: Transition.native,duration: Duration(milliseconds:400 )),
                    title: Text(snapshot.data.docs[index]["Category"]),
                  );
                },
              );
            }
            else{
              return Text("");
            }
          },
        ),
      ),
    );
  }
}