
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order online",
          style: TextStyle(fontSize: 35, fontFamily: "figerona"),
        ),
        Text(
          "Collect instore",
          style: TextStyle(fontSize: 35, fontFamily: "figerona"),
        )
      ],
    );
  }
}
