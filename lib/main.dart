
import 'package:ecomp/Pages/HomePage.dart';
import 'package:ecomp/Pages/LoginPage.dart';
import 'package:ecomp/Providers/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
Color primaryColor = Color.fromARGB(255, 64, 89, 231);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Auth(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
          child: CircularProgressIndicator(),
        );
        }
        else if(snapshot.hasData){
          return HomePage();
        }
        else if(snapshot.hasError){
          return Center(child: Text("Something Went Wrong"),);
        }
        else{
          return Login();
        }
        
      }
    );
  }
}

