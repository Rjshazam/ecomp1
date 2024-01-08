// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class NetworkFailed extends StatefulWidget {
//   NetworkFailed({Key? key}) : super(key: key);

//   @override
//   State<NetworkFailed> createState() => _NetworkFailedState();
// }

// class _NetworkFailedState extends State<NetworkFailed> {
//   late StreamSubscription subscription;
//   bool isDeviceConnected = false;
//   bool isAlertSet = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Text("No Connection"),
//           ),
//           ElevatedButton(onPressed: ()async{
//             setState(() => isAlertSet = false);
//                 isDeviceConnected =
//                     await InternetConnectionChecker().hasConnection;
//                 if (!isDeviceConnected && isAlertSet == false) {
//                   showDialogBox();
//                   setState(() => isAlertSet = true);
//                 }
//           }, child: Text("Retry"))
//         ],
//       ),
//     );
//   }
// }