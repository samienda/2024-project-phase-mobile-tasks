import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushNamed(context, '/login'),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.withOpacity(0.3),
              const Color(0xFF3F51F3).withOpacity(0.7),
              const Color.fromARGB(255, 0, 8, 255),
              const Color.fromARGB(255, 0, 8, 255),
            ],
          ),
          image: const DecorationImage(
            opacity: 0.1,
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/image.png'),
          ),
        ),
        child: Center(
          heightFactor: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                child: Center(
                  child: Text(
                    'ECOM',
                    style: GoogleFonts.caveatBrush(
                      color: const Color.fromARGB(255, 19, 41, 245),
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'ECOMMERCE APP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
