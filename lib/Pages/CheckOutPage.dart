import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomp/Pages/HomePage.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String _value = 'Cash on delivery';
  Random random = new Random();
  QuerySnapshot<Map<String, dynamic>>? detailStream;
  getDetails() async {
    setState(() {
      FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .collection('Shipping')
          .get()
          .then((value) {
        detailStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressConrtroller = TextEditingController();
    int randomNumber = random.nextInt(1000000);
    final key = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Checkout"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Shipping Details:",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "figerona",
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("User")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("Shipping")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length != 0) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
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
                                                                    "Change Shipping Information",
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
                                                                            .update({
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
                                            child: Container(
                                                // color: Colors.transparent,
                                                height: 20,
                                                width: 50,
                                                child: Text(
                                                  "Change",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data.docs[0]["Name"],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "figerona"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          snapshot.data.docs[0]["Address"],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "figerona"),
                                        ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data.docs[0]["Phone"],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "figerona"),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          FirebaseAuth
                                              .instance.currentUser!.email
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "figerona"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 50,
                                  color: Colors.white,
                                ),
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                child: Form(
                                                  key: key,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          "Add Shipping Information",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              nameController,
                                                          validator: (value) {
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
                                                              prefixIcon: Icon(
                                                                  Icons.person),
                                                              label:
                                                                  Text("Name")),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              addressConrtroller,
                                                          validator: (value) {
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
                                                              prefixIcon: Icon(
                                                                  Icons.home),
                                                              label: Text(
                                                                  "Address")),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              phoneController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Enter Phone Number";
                                                            }
                                                          },
                                                          decoration: const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  "Enter Phone number",
                                                              prefixIcon: Icon(
                                                                  Icons.phone),
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
                                                                      .instance
                                                                      .currentUser!
                                                                      .email)
                                                                  .collection(
                                                                      "Shipping")
                                                                  .doc("1")
                                                                  .set({
                                                                "Name":
                                                                    nameController
                                                                        .text,
                                                                "Address":
                                                                    addressConrtroller
                                                                        .text,
                                                                "Phone":
                                                                    phoneController
                                                                        .text
                                                              }).then((value) =>
                                                                      Navigator.pop(
                                                                          context));
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 70,
                                                            width: 300,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    64,
                                                                    89,
                                                                    231)),
                                                            child: const Text(
                                                              "Continue",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "figerona",
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .white),
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
                                      });
                                },
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Payments Methods:",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "figerona",
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white;
                                    }
                                    return Colors.white;
                                  }),
                                  value: "Cash on delivery",
                                  groupValue: _value,
                                  onChanged: (val) {
                                    setState(() {
                                      _value = val as String;
                                      print(_value);
                                    });
                                  }),
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(FontAwesomeIcons.moneyBill),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Cash on delivery",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white;
                                    }
                                    return Colors.white;
                                  }),
                                  value: 'UPI',
                                  groupValue: _value,
                                  onChanged: (val) {
                                    setState(() {
                                      _value = val as String;
                                      print(val);
                                    });
                                  }),
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(FontAwesomeIcons.googlePay),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('UPI',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white;
                                    }
                                    return Colors.white;
                                  }),
                                  value: 'Card',
                                  groupValue: _value,
                                  onChanged: (val) {
                                    setState(() {
                                      _value = val as String;
                                      print(val);
                                    });
                                  }),
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(FontAwesomeIcons.creditCard),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Card',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
                          if (total != 0) {
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
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    getDetails();
                                    final user =
                                        FirebaseAuth.instance.currentUser!;
                                    QuerySnapshot querySnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('User')
                                            .doc(user.email)
                                            .collection('Cart')
                                            .get();

                                    querySnapshot.docs.forEach((result) {
                                      total += int.parse(result['Price']) *
                                          int.parse(result['Quantity']);
                                    });
                                    final allData = querySnapshot.docs
                                        .map((doc) => doc.data())
                                        .toList();
                                    final String format = DateFormat('d-MM-y')
                                        .format(DateTime.now());
                                    Map<String, dynamic> orders = {
                                      'Orders': allData,
                                      'User': user.displayName,
                                      'Name': detailStream!.docs[0]["Name"],
                                      'Address': detailStream!.docs[0]
                                          ["Address"],
                                      'Phone': detailStream!.docs[0]["Phone"],
                                      'Email': user.email,
                                      'Payment': _value,
                                      'Total': total,
                                      'OrderNumber': randomNumber,
                                      'Date': format,
                                      'Status' : 'pending',
                                      
                                    };
                                    FirebaseFirestore.instance
                                        .collection('User')
                                        .doc(user.email)
                                        .collection('Orders')
                                        .doc(randomNumber.toString())
                                        .set(orders);

                                    FirebaseFirestore.instance
                                        .collection('AllOrders')
                                        .doc(randomNumber.toString())
                                        .set(orders);

                                    FirebaseFirestore.instance
                                        .collection('User')
                                        .doc(user.email)
                                        .collection('Cart')
                                        .get()
                                        .then((value) {
                                      for (DocumentSnapshot ds in value.docs) {
                                        ds.reference.delete();
                                      }
                                    });
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomePage()));
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
                                      "Confirm and Pay",
                                      style: TextStyle(
                                          fontFamily: "figerona",
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
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
