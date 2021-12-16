import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nisham/page/walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkOnboarding();
    super.initState();
  }

  checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDone = prefs.getBool('walkThrough') ?? false;
    if (!isDone) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WalkthroughPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
