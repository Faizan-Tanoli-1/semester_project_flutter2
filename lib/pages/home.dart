import 'package:flutter/material.dart';
import 'package:sem_project/services/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // menu icon three dots
              Icon(Icons.menu, size: 30.0,),
              SizedBox(height: 10.0,),
              // question to the user
              Text("What Would You\nLike To Cook?", style: AppWidget.healingTextstyle(35.0),),
              SizedBox(height: 10.0,),
              // search bar
              Container(
                height: 60,
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(color: const Color.fromARGB(41, 33, 149, 243), borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: "Search Recipe...",prefixIcon: Icon(Icons.search), hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // todays recipe section
              Text("Today's Recipe", style: AppWidget.healingTextstyle(24.0),),
              SizedBox(height: 10.0,),
              Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    // recipe box
                    Container(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20.0),
                            child: Image.asset('images/pizza.jpg', height: 260, width: 200, fit: BoxFit.cover,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 160,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(left: 18.0, top: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(48, 255, 255, 255)
                                ),
                                child: Column(
                                  children: [
                                    Text("Cheese Pizza", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("30 MIN | EASY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 18.0,),
                    // recipe box
                    Container(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20.0),
                            child: Image.asset('images/burger.jpg', height: 260, width: 200, fit: BoxFit.cover,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 160,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(left: 18.0, top: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(48, 255, 255, 255)
                                ),
                                child: Column(
                                  children: [
                                    Text("Cheese Burger", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("20 MIN | EASY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              // recommended section
              Text("Recommended", style: AppWidget.healingTextstyle(24.0),),
              SizedBox(height: 10,),
              // recommend box
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("images/muffin.jpg", height: 120, width: 120, fit: BoxFit.cover,)
                    ),
                    SizedBox(width: 20.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0,),
                        Text("Muffins With Cocoa\nCream", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                        Text("By Faizan Tanoli", style: TextStyle(color: const Color.fromARGB(121, 0, 0, 0), fontWeight: FontWeight.w500, fontSize: 16.0),),
                        SizedBox(height: 5.0,),
                        Row(
                          children: [
                            Icon(Icons.alarm, color: Colors.green, size: 30.0,),
                            SizedBox(width: 10.0,),
                            Text("30 MIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
                            SizedBox(width: 10.0,),
                            Icon(Icons.book, color: Colors.green, size: 30.0,),
                            SizedBox(width: 10.0,),
                            Text("EASY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              // recommend box
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("images/sandwich.jpg", height: 120, width: 120, fit: BoxFit.cover,)
                    ),
                    SizedBox(width: 20.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0,),
                        Text("Sandwich With\nVegetables", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                        Text("By Faizan Tanoli", style: TextStyle(color: const Color.fromARGB(121, 0, 0, 0), fontWeight: FontWeight.w500, fontSize: 16.0),),
                        SizedBox(height: 5.0,),
                        Row(
                          children: [
                            Icon(Icons.alarm, color: Colors.green, size: 30.0,),
                            SizedBox(width: 10.0,),
                            Text("10 MIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
                            SizedBox(width: 10.0,),
                            Icon(Icons.book, color: Colors.green, size: 30.0,),
                            SizedBox(width: 10.0,),
                            Text("MEDIUM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}