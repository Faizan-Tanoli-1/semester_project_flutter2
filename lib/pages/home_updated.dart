import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sem_project/pages/signin.dart';
import 'package:sem_project/pages/detail_page.dart';
import 'package:sem_project/services/widget_support.dart';
import 'package:sem_project/services/database.dart';
import 'package:sem_project/admin/add_recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final bool showSuccess;
  const Home({super.key, this.showSuccess = false});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();

    // 🔹 Show success message after recipe added
    if (widget.showSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recipe added successfully"),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Colors.green),
              title: const Text('Add Recipe'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRecipePage(),
                  ),
                );
              },
            ),
            Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                User? user = FirebaseAuth.instance.currentUser;
                // Sign out logic would go here
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Text(
                  "What Would You\nLike To Cook?",
                  style: AppWidget.healingTextstyle(35),
                ),

                const SizedBox(height: 15),

                // Search Bar
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim().toLowerCase();
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Recipe...",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ================= TODAY'S RECIPE (FIRESTORE) =================
                Text("Today's Recipe", style: AppWidget.healingTextstyle(24)),
                const SizedBox(height: 12),

                SizedBox(
                  height: 260,
                  child: FutureBuilder<QuerySnapshot>(
                    future: DatabaseMethods().getTodaysRecipes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "There is no Recipe",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.docs.map((recipe) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      image:
                                          recipe["image"] ?? "images/pizza.jpg",
                                      title: recipe["recipeName"] ?? "",
                                      time: recipe["timeTaken"] ?? "",
                                      level: recipe["level"] ?? "Easy",
                                      ingredients: recipe["ingredients"] ?? '',
                                      directions: recipe["directions"] ?? '',
                                    ),
                                  ),
                                );
                              },
                              child: _todayRecipe(
                                image: recipe["image"] ?? "images/pizza.jpg",
                                title: recipe["recipeName"],
                                info:
                                    "${recipe["timeTaken"]} | ${recipe["level"] ?? "EASY"}",
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ================= RECOMMENDED (FIRESTORE) =================
                Text("Recommended", style: AppWidget.healingTextstyle(24)),
                const SizedBox(height: 12),

                StreamBuilder<QuerySnapshot>(
                  stream: DatabaseMethods().getRecipes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("No recipes added yet"),
                      );
                    }

                    // Filter recipes based on search query
                    List<QueryDocumentSnapshot> filteredRecipes = snapshot
                        .data!
                        .docs
                        .where((recipe) {
                          String recipeName = (recipe["recipeName"] ?? "")
                              .toString()
                              .toLowerCase();
                          return recipeName.contains(searchQuery);
                        })
                        .toList();

                    // Show no result message if search query doesn't match any recipe
                    if (searchQuery.isNotEmpty && filteredRecipes.isEmpty) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "No result found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredRecipes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var recipe = filteredRecipes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    image:
                                        recipe["image"] ?? "images/muffin.jpg",
                                    title: recipe["recipeName"] ?? "",
                                    time: recipe["timeTaken"] ?? "",
                                    level: recipe["level"] ?? "Easy",
                                    ingredients: recipe["ingredients"] ?? '',
                                    directions: recipe["directions"] ?? '',
                                  ),
                                ),
                              );
                            },
                            child: _recommendedRecipe(
                              image: "images/muffin.jpg", // static image
                              title: recipe["recipeName"],
                              time: recipe["timeTaken"],
                              level: recipe["level"] ?? "Easy",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= TODAY'S RECIPE CARD =================
  Widget _todayRecipe({
    required String image,
    required String title,
    required String info,
  }) {
    return SizedBox(
      width: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              height: 260,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    info,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= RECOMMENDED CARD =================
  Widget _recommendedRecipe({
    required String image,
    required String title,
    required String time,
    required String level,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "By Faizan Tanoli",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.alarm, color: Colors.green),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.book, color: Colors.green),
                    const SizedBox(width: 5),
                    Text(
                      level,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
