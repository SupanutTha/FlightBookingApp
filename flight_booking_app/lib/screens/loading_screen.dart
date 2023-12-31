import 'package:flight_booking_app/screens/home_screen.dart';
import 'package:flight_booking_app/utilities/create_db.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

 

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    createState();
    hideScreen();
  }

  ///hide your splash screen
  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 6000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  Future<void> createState () async {
     final createDb = CreateDb();
    await createDb.createAirplaneAirlineDb();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFEC441E),
      body: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/lottie/animation_lm3no1er.json'),
            const Text(
              'Go a Where',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFFEC441E),
                  fontFamily: 'Amiri Quran Colored',
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        )
      ),
    );
  }
}