import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nisham/page/splash.dart';
import 'package:nisham/page/walkthrough.dart';
import 'package:provider/provider.dart';
import 'package:nisham/page/home_page.dart';
import 'package:nisham/provider/todos.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'My Personal List';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: Color(0xFFf6f5ee),
          ),
          home: SplashPage(),
        ),
      );
}
