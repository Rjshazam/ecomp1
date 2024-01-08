import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  final String image;
  final String title;
  final String nickname;
  final String price;
  final String description;
  final String category;
  final bool inStock;
  DetailsPage(
      {Key? key,
      required this.image,
      required this.title,
      required this.nickname,
      required this.price,
      required this.description,
      required this.category,
      required this.inStock})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
   bool isSaved = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.email).collection("Saved").doc(widget.title)
        .get()
        .then((doc) {
      if(doc.exists) {
        setState(() {
          isSaved = true;
        });
      } else {
        setState(() {
          isSaved = false;
        });
      }
      print(isSaved);
    });
  }
  int qty = 1;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (){
              isSaved ? FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Saved").doc(widget.title).delete().then((value) {
                Fluttertoast.showToast(msg: "Item removed from saved list...",backgroundColor: primaryColor,textColor: Colors.white);
                setState(() {
                  isSaved = false;
                });
              })
               : FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Saved").doc(widget.title).set({
                'Nickname':widget.nickname,
                "Image":widget.image,
                "Price":widget.price,
                "Title":widget.title,
                "Category":widget.category
               }).then((value){
                Fluttertoast.showToast(msg: "${widget.nickname} is added to saved list...",backgroundColor: primaryColor,textColor: Colors.white);
                setState(() {
                  isSaved = true;
                });
               });
            }, 
            icon: isSaved? const Icon(Icons.favorite):const Icon(Icons.favorite_border))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style: TextStyle(fontFamily: "figerona", fontSize: 20)),
                  Text("Rs: ${widget.price}",
                      style: TextStyle(
                          fontFamily: "figerona",
                          fontSize: 20,
                          color: primaryColor))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Quantity: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "figerona",
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (qty != 1) {
                                setState(() {
                                  qty = (qty - 1);
                                });
                              }
                            });
                          },
                          icon: const Icon(Icons.remove)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(qty.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (qty != 10) {
                                setState(() {
                                  qty = (qty + 1);
                                  // ignore: avoid_print
                                  print(qty);
                                });
                              }
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection('User')
                          .doc(FirebaseAuth.instance.currentUser!.email
                              .toString())
                          .collection('Cart')
                          .doc(widget.title);
                      Map<String, dynamic> add = {
                        'Title': widget.title.toString(),
                        'Price': widget.price.toString(),
                        'Image': widget.image.toString(),
                        'Quantity': qty.toString(),
                        'Nickname': widget.nickname,
                        'isRated':false
                      };
                      documentReference.set(add).then((value) {
                        Fluttertoast.showToast(
                            msg:
                                "${widget.nickname} with $qty is added to cart.");
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: ImageSlideshow(
                  children: [
                    Image.network(widget.image),
                    Image.network(widget.image),
                    Image.network(widget.image)
                  ],
                ),
              ),
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 120,
                          child: Text(
                            widget.title,
                            style:
                                const TextStyle(fontFamily: "figerona", fontSize: 15),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              "Description:",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontFamily: "figerona",
                                                  fontSize: 25),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              widget.description,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "figerona",
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Full Description",
                            style: TextStyle(color: primaryColor),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
