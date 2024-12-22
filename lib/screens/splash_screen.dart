import 'package:flutter/material.dart';
import 'package:kwave/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/kwave.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text('KWave',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade900)),
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('from',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              Text('Faradaii',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}