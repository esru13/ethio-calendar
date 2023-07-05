import 'package:ethio_calend/main.dart';
// import 'package:ethio_tour/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _goToHome();
  }
  _goToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Welcome To Ethiopia",)));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#093A3E'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(90.0),
            child: Container(
              child: Image.asset('assets/images/man.png'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
