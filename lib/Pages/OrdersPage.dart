import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'HomePage.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  QuerySnapshot<Map<String, dynamic>>? starStream;
  List<Order> orders = [];
  final user = FirebaseAuth.instance.currentUser!;
  double rate = 0;
  getStars() {
    FirebaseFirestore.instance.collection("Products").get().then((value) {
      starStream = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStars();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("Orders")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length != 0) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final List ord = snapshot.data.docs[index]["Orders"];
                      return Container(
                        // height: 300,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        // child: Container(
                        //   height: 100,
                        //   child: ListView.builder(
                        //     itemCount: ord.length,
                        //     itemBuilder: (BuildContext context, int ind) {
                        //       return Text(ord[ind]["Nickname"]);
                        //     },
                        //   ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Order No: ",
                                    style: TextStyle(
                                        // color: primaryColor,
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "figerona"),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]["OrderNumber"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "figerona"),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]["Date"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]["Name"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Text(
                                    snapshot.data.docs[index]["Address"]
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]["Email"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]["Status"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Items >>",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text("Total: Rs.",
                                      style: TextStyle(
                                          // color: primaryColor,
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: "figerona")),
                                  Text(
                                      snapshot.data.docs[index]["Total"]
                                          .toString(),
                                      style: TextStyle(
                                          // color: primaryColor,
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: "figerona")),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 220,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 20,
                                  ),
                                  itemCount: ord.length,
                                  itemBuilder: (BuildContext context, int ind) {
                                    return Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 150,
                                          width: 150,
                                          child:
                                              Image.network(ord[ind]["Image"]),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Rs.",
                                              style: TextStyle(
                                                  fontFamily: "figerona",
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ord[ind]["Price"],
                                              style: TextStyle(
                                                  fontFamily: "figerona",
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Oty: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "figerona"),
                                            ),
                                            Text(
                                              ord[ind]["Quantity"],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "figerona",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (snapshot.data.docs[index]["Status"] ==
                                      "Deliverd")
                                    GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                  height: 250,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                        width: 20,
                                                      ),
                                                      itemCount: ord.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int ind) {
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              height: 150,
                                                              width: 150,
                                                              child: Image
                                                                  .network(ord[
                                                                          ind][
                                                                      "Image"]),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              Container(
                                                                            height:
                                                                                150,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text("Rating"),
                                                                                SizedBox(
                                                                                  height: 15,
                                                                                ),
                                                                                RatingBar.builder(
                                                                                  initialRating: 3,
                                                                                  minRating: 1,
                                                                                  direction: Axis.horizontal,
                                                                                  allowHalfRating: true,
                                                                                  itemCount: 5,
                                                                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                                  itemBuilder: (context, _) => Icon(
                                                                                    Icons.star,
                                                                                    color: Colors.amber,
                                                                                  ),
                                                                                  onRatingUpdate: (rating) {
                                                                                    setState(() {
                                                                                      rate = rating;
                                                                                      print(rate);
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                MaterialButton(
                                                                                  onPressed: () {
                                                                                    print(rate);
                                                                                    FirebaseFirestore.instance.collection("Products").doc(ord[ind]["Title"]).update({
                                                                                      "Star": FieldValue.increment(rate),
                                                                                      "Revcount": FieldValue.increment(1)
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Rate",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                  color: primaryColor,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child: Text(
                                                                  "Select",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primaryColor),
                                                                ))
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          "Review",
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ))
                                  else
                                    Text("")
                                ],
                              )
                            ],
                          ),
                        ),
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
                        Text(
                          "No Orders Placed Yet.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "figerona",
                              fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage())),
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 64, 89, 231)),
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
              return Container();
            }
          },
        ),
      ),
    );
  }
}
