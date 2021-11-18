import 'package:flutter/material.dart';
import 'package:miaou/login.dart';
import 'package:miaou/register.dart';
import 'package:miaou/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'splash': (context) => SplashScreen(),
    },
  ));
}

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miaou l\'application',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Miaou le chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Miaou'),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(
              builder: (context){
              return Map();
          },));}
        ),
      ),
    );
  }
}*/
