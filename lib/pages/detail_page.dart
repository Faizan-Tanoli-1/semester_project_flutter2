import 'package:flutter/material.dart';
import 'package:sem_project/services/widget_support.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String time;
  final String level;
  final String ingredients;
  final String directions;

  const DetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.level,
    this.ingredients = '',
    this.directions = '',
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to size info boxes to prevent overflow on small screens
    final double screenWidth = MediaQuery.of(context).size.width;
    // subtract left padding (20), internal paddings and gaps between boxes (~40)
    final double availableWidth = screenWidth - 20 - 40;
    final double boxWidth = (availableWidth / 3).clamp(80.0, 160.0);
    final double boxHeight = (MediaQuery.of(context).size.height * 0.18).clamp(
      110.0,
      160.0,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // curve app bar with picture
          child: Stack(
            children: [
              Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    // recipe heading
                    Text(widget.title, style: AppWidget.healingTextstyle(30.0)),
                    SizedBox(height: 20.0),
                    // alarm box
                    Row(
                      children: [
                        // box
                        Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xffddf1e6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/alarm.png",
                                height: (boxHeight * 0.38).clamp(32.0, 56.0),
                                width: (boxHeight * 0.38).clamp(32.0, 56.0),
                                fit: BoxFit.contain,
                                color: const Color(0xff5ab38a),
                              ),
                              const SizedBox(height: 8.0),
                              Flexible(
                                child: Text(
                                  widget.time,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xff5ab38a),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        // box
                        Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0db),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/smiley.png",
                                height: (boxHeight * 0.38).clamp(32.0, 56.0),
                                width: (boxHeight * 0.38).clamp(32.0, 56.0),
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 8.0),
                              Flexible(
                                child: Text(
                                  widget.level.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xffe4b46b),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        // box
                        Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xffe7eefa),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/fire.png",
                                height: (boxHeight * 0.38).clamp(32.0, 56.0),
                                width: (boxHeight * 0.38).clamp(32.0, 56.0),
                                fit: BoxFit.contain,
                                color: const Color(0xff7fb1dc),
                              ),
                              const SizedBox(height: 8.0),
                              const Flexible(
                                child: Text(
                                  "-- CAL",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xff7fb1dc),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // ingredients
                    SizedBox(height: 20.0),
                    Text(
                      "Ingredients :",
                      style: AppWidget.healingTextstyle(25.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.ingredients.isNotEmpty
                          ? widget.ingredients
                          : 'No ingredients provided.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Directions: ",
                      style: AppWidget.healingTextstyle(25.0),
                    ),
                    Text(
                      widget.directions.isNotEmpty
                          ? widget.directions
                          : 'No directions provided.',
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
