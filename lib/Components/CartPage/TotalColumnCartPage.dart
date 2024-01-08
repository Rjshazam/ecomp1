
import 'package:flutter/material.dart';

import '../../main.dart';

class TotalColumnCartPage extends StatelessWidget {
  const TotalColumnCartPage({
    Key? key,
    required this.total,
  }) : super(key: key);

  final int total;

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    Color.fromARGB(255, 64, 89, 231)),
            child: Text(
              "Checkout",
              style: TextStyle(
                  fontFamily: "figerona",
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ],
      );
  }
}
