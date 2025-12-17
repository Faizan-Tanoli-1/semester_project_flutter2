import 'package:flutter/material.dart';
import 'package:sem_project/services/widget_support.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // curve app bar with picture
          child: Stack(
            children: [
              Image.asset('images/burger.jpg', height: MediaQuery.of(context).size.height/2.5, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(60)),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    // recipe heading
                    Text("Cheese Burger" , style: AppWidget.healingTextstyle(30.0),),
                    SizedBox(height: 20.0,),
                    // alarm box
                    Row(
                      children: [
                        // box
                        Container(
                          height: 130,
                          width: 110,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: 
                          Color(0xffddf1e6), borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/alarm.png", height: 50, width: 50, fit: BoxFit.cover, color: Color(0xff5ab38a),),
                              SizedBox(height: 10.0,),
                              Text("40 MIN", style: TextStyle(color: Color(0xff5ab38a), fontSize: 15.0, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        // box
                        Container(
                          height: 130,
                          width: 110,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: 
                          Color(0xfffdf0db), borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/smiley.png", height: 50, width: 50, fit: BoxFit.cover,),
                              SizedBox(height: 10.0,),
                              Text("MEDIUM", style: TextStyle(color: Color(0xffe4b46b), fontSize: 15.0, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        // box
                        Container(
                          height: 130,
                          width: 110,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: 
                          Color(0xffe7eefa), borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/fire.png", height: 50, width: 50, fit: BoxFit.cover,color: Color(0xff7fb1dc),),
                              SizedBox(height: 10.0,),
                              Text("300 CAL", style: TextStyle(color: Color(0xff7fb1dc), fontSize: 15.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // ingredients
                    SizedBox(height: 20.0,),
                    Text("Ingredients :", style: AppWidget.healingTextstyle(25.0),),
                    SizedBox(height: 10.0,),
                    Text(
                      "• Burger Bun – 1 piece\n"
                      "• Beef or Chicken Patty – 1 piece (120g)\n"
                      "• Cheese Slice – 1 slice\n"
                      "• Lettuce – 1 leaf\n"
                      "• Tomato Slices – 2 slices\n"
                      "• Onion Rings – 3 rings\n"
                      "• Mayonnaise – 1 tbsp\n"
                      "• Ketchup – 1 tbsp",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Text("Directions: ", style: AppWidget.healingTextstyle(25.0),),
                    Text(
                      "To make a cheese burger, start by lightly toasting the burger bun. Cook the beef or chicken patty on a grill or pan until fully done, then place a slice of cheese on top to melt. Assemble the burger by layering the bottom bun with lettuce, tomato slices, the cheesy patty, onion rings, and your preferred sauces, then cover with the top bun. Serve immediately while hot.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 50.0, left: 20.0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 25.0,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}