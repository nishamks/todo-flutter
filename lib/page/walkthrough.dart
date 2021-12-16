import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nisham/helper/Constant.dart';
import 'package:nisham/helper/Images.dart';
import 'package:nisham/helper/Colors.dart';
import 'package:nisham/helper/Strings.dart';
import 'package:nisham/page/home_page.dart';
import 'package:nisham/widget/app_widget.dart';

import '../../main.dart';

class WalkthroughPage extends StatefulWidget {
  @override
  WalkthroughPageState createState() => WalkthroughPageState();
}

class WalkthroughPageState extends State<WalkthroughPage> {
  int currentIndexPage = 0;
  var titles = [
    quickly_and_easily,
    shopping_online,
    manage_your_finance,
    welcome_to_mollet
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
  }

  Future<void> setWalkthroughDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('walkThrough', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: <Widget>[
                  WalkThrough(
                      textContent: quickly_and_easily,
                      bgImg: t5_bg_walk_1,
                      walkImg: t5_bg_walk_1),
                  WalkThrough(
                      textContent: shopping_online,
                      bgImg: t5_walk_2,
                      walkImg: t5_bg_walk_1),
                  WalkThrough(
                      textContent: manage_your_finance,
                      bgImg: t5_bg_walk_3,
                      walkImg: t5_bg_walk_1),
                  WalkThrough(
                    textContent: welcome_to_mollet,
                    walkImg: t5_bg_walk_1,
                    onClicked: () {
                      setWalkthroughDone().then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ],
                onPageChanged: (value) {
                  setState(() => currentIndexPage = value);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DotsIndicator(
                    dotsCount: 4,
                    position: currentIndexPage.toDouble(),
                    decorator: DotsDecorator(
                      size: Size.square(8.0),
                      activeSize: Size.square(12.0),
                      color: Colors.grey,
                      activeColor: t5ColorPrimary,
                    )),
              ),
            )
          ],
        ));
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;
  final String bgImg;
  final String walkImg;
  final VoidCallback onClicked;

  WalkThrough(
      {Key key, this.textContent, this.bgImg, this.walkImg, this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: h * 0.05),
                height: h * 0.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    bgImg != null
                        ? Image.asset(bgImg,
                            width: width, height: h * 0.5, fit: BoxFit.fill)
                        : Container(),
                    // CachedNetworkImage(
                    //   imageUrl: walkImg,
                    //   width: width * 0.8,
                    //   height: h * 0.6,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.08,
              ),
              text(textContent ?? "",
                  textColor: whiteColor,
                  fontSize: textSizeNormal,
                  fontFamily: fontMedium),
              Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.simply duumy text ",
                    fontSize: textSizeMedium,
                    textColor: textSecondaryColor,
                    maxLine: 3,
                    isCentered: true),
              )
            ],
          ),
        ),
        bgImg == null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: onClicked,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                    alignment: Alignment.center,
                    height: width / 8,
                    child: text("Get Started",
                        textColor: t5White, isCentered: true),
                    decoration:
                        boxDecoration(bgColor: t5ColorPrimary, radius: 8),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
