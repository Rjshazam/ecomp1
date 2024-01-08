import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Pages/DetailsPage.dart';
import '../../main.dart';


class SearchProductTile extends StatelessWidget {
  final String image;
  final String title;
  final String nickname;
  final String price;
  final String description;
  final String category;
  final bool inStock;
  const SearchProductTile({
    Key? key,
    required this.data, required this.image, required this.title, required this.nickname, required this.price, required this.description, required this.category, required this.inStock,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            DetailsPage(
                image: image,
                title: title,
                nickname: nickname,
                price: price,
                description:description,
                category: category,
                inStock: inStock),
            transition: Transition.fade,
            duration: Duration(milliseconds: 500));
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[2],
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                height: 300,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          data["Nickname"],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      Text(
                          data
                              ["Category"],
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Price: ${data["Price"]} /-",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 200,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  // color: Colors.white
                ),
                height: 190,
                width: 190,
                child: Image.network(
                  data['Image'],
                  scale: 3,
                ),
              )),
        ],
      ),
    );
  }
}
