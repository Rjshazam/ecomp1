import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                double star =
                    double.parse(snapshot.data.docs[index]["Star"].toString());
                int revcount =
                    int.parse(snapshot.data.docs[index]["Revcount"].toString());
                double rating = star / revcount;
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        DetailsPage(
                            image: snapshot.data.docs[index]["Image"],
                            title: snapshot.data.docs[index]["Title"],
                            nickname: snapshot.data.docs[index]["Nickname"],
                            price: snapshot.data.docs[index]["Price"],
                            description: snapshot.data.docs[index]["Dec"],
                            category: snapshot.data.docs[index]["Category"],
                            inStock: snapshot.data.docs[index]["InStock"]),
                        transition: Transition.fade,
                        duration: Duration(milliseconds: 500));
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[2],
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(25)),
                            height: 300,
                            width: 210,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 80, left: 8, right: 8),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data.docs[index]["Nickname"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(snapshot.data.docs[index]["Category"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  // SizedBox(height: 30,),
                                  star != 0
                                      ? Text(
                                          "${rating.toString()}(${revcount.toString()})",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15))
                                      : Text("No ratings",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                  Spacer(),

                                  Text(
                                    "Price: ${snapshot.data.docs[index]["Price"]} /-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 160,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              // color: Colors.white
                            ),
                            height: 190,
                            width: 190,
                            child: Image.network(
                              snapshot.data.docs[index]['Image'],
                              scale: 3,
                            ),
                          )),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text("Nothing");
          }
        },
      ),
    );
  }
}
