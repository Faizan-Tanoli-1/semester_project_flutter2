import 'package:flutter/material.dart';
import 'package:sem_project/services/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/onboard.png'),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("25k+ PREMIUM RECIPIES" , style: TextStyle(color: const Color.fromARGB(143, 0, 0, 0), fontSize: 16.0, fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Its's\nCooking Time!", style: AppWidget.healingTextstyle(50.0),),
            ),
            SizedBox(height: 40.0,),
            Center(
              child: Container(
                height: 70,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(60)),
                width: 300,
                child: Center(child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}