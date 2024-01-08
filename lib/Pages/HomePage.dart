import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecomp/Components/HomePage/AccessoriesTile.dart';
import 'package:ecomp/Components/HomePage/ClothingTile.dart';
import 'package:ecomp/Components/HomePage/ElectronicsTile.dart';
import 'package:ecomp/Pages/CartPage.dart';
import 'package:ecomp/Pages/More.dart';
import 'package:ecomp/Pages/NetworkFailed.dart';
import 'package:ecomp/Pages/OrdersPage.dart';
import 'package:ecomp/Pages/ProfilePage.dart';
import 'package:ecomp/Pages/SearchPage.dart';
import 'package:ecomp/Pages/savedProducts.dart';
import 'package:ecomp/Providers/AuthProvider.dart';
import 'package:ecomp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../Components/HomePage/HomepageTitle.dart';
import '../Components/HomePage/ProductTile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
    void initState() {
      super.initState();
     
      
    }
  
  @override
  Widget build(BuildContext context) {
    

    TabController tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Ecommerce App"),
        actions: [
          MaterialButton(
              onPressed: () {
                Get.to(SearchPage(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 500));
              },
              child: Icon(
                Icons.search_outlined,
                color: primaryColor,
              )),
        ],
      ),
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: Column(
          children: [
            DrawerHeader(
                child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () => Get.to(ProfilePage(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 500)),
                      child: Column(
                        children: [
                         
                          FirebaseAuth.instance.currentUser!.photoURL
                                      .toString() ==
                                  "null"
                              ? Container(
                                alignment: Alignment.center,
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    snapshot.data["name"]
                                        .toString()
                                        .toUpperCase()
                                        .substring(0, 1),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50,
                                        color: primaryColor),
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
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data["name"],
                            style: TextStyle(
                                color: Colors.white, fontFamily: "figerona"),
                          )
                        ],
                      ),
                    );
                  } else {
                    return CircleAvatar();
                  }
                },
              ),
            )),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () => Get.to(ProfilePage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              leading: Icon(
                FontAwesomeIcons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () => Get.toEnd(() => HomePage()),
              leading: Icon(
                FontAwesomeIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () => Get.to(CartPage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              leading: Icon(
                FontAwesomeIcons.cartShopping,
                color: Colors.white,
              ),
              title: Text(
                "Cart",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: ()=> Get.to(OrdersPage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              leading: Icon(
                FontAwesomeIcons.shoppingBag,
                color: Colors.white,
              ),
              title: Text(
                "Orders",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () => Get.to(SavedProductsPage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500)),
              leading: Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.white,
              ),
              title: Text(
                "favourite",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                final provider = Provider.of<Auth>(context, listen: false);
                provider.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Main()));
              },
              leading: Icon(
                FontAwesomeIcons.signOut,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  HomeTitle(),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: TabBar(
                        unselectedLabelStyle:
                            TextStyle(fontWeight: FontWeight.normal),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        indicatorColor: primaryColor,
                        labelColor: primaryColor,
                        unselectedLabelColor: Colors.black,
                        isScrollable: true,
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: "All",
                          ),
                          Tab(
                            text: "Clothing",
                          ),
                          Tab(
                            text: "Electronics",
                          ),
                          Tab(
                            text: "Acessories",
                          ),
                          // Tab(
                          //   text: "Music",
                          // ),
                          // Tab(
                          //   text: "Cables",
                          // ),
                          Tab(
                            text: "More",
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 360,
                    child: TabBarView(controller: tabController, children: [
                      ProductTile(),
                      ClothingTile(),
                      ElectronicsTile(),
                      AcessoriesTile(),
                      MoreCat()
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

