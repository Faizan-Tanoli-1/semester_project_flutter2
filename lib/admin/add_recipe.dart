import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sem_project/services/database.dart';
import 'package:sem_project/pages/home.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController recipenameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  String recipeType = "Recommended"; // Default recipe type
  String recipeLevel = "Easy"; // Default difficulty level

  @override
  void dispose() {
    recipenameController.dispose();
    timeController.dispose();
    ingredientsController.dispose();
    directionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // 🔹 BACK BUTTON → ALWAYS HOME
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          },
        ),

        centerTitle: true,
        title: const Text(
          "Add Recipe",
          style: TextStyle(
            fontFamily: 'Fredoka',
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Recipe Type"),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: recipeType,
                isExpanded: true,
                underline: const SizedBox(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    recipeType = newValue!;
                  });
                },
                items: <String>["Recommended", "Today's Recipe"]
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
              ),
            ),

            const SizedBox(height: 15),

            _label("Recipe Level"),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: recipeLevel,
                isExpanded: true,
                underline: const SizedBox(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    recipeLevel = newValue!;
                  });
                },
                items: <String>["Easy", "Medium", "Hard"]
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
              ),
            ),

            const SizedBox(height: 15),

            _label("Recipe Name"),
            _field("Enter recipe name", recipenameController),

            const SizedBox(height: 15),
            _label("Time Taken"),
            _field("2 h", timeController),

            const SizedBox(height: 15),

            _label("Ingredients"),
            _field("Ingredients...", ingredientsController, maxLines: 4),

            const SizedBox(height: 15),

            _label("Directions"),
            _field("Directions...", directionsController, maxLines: 4),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _addRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add Recipe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= FIREBASE LOGIC =================
  Future<void> _addRecipe() async {
    if (recipenameController.text.isEmpty ||
        timeController.text.isEmpty ||
        ingredientsController.text.isEmpty ||
        directionsController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    Map<String, dynamic> recipeMap = {
      "image": "images/pizza.jpg", // static for now
      "recipeName": recipenameController.text.trim(),
      "timeTaken": timeController.text.trim(),
      "ingredients": ingredientsController.text.trim(),
      "directions": directionsController.text.trim(),
      "level": recipeLevel,
      "createdAt": FieldValue.serverTimestamp(),
    };

    if (recipeType == "Recommended") {
      await DatabaseMethods().addRecipe(recipeMap);
    } else {
      await DatabaseMethods().addTodaysRecipe(recipeMap);
    }

    // 🔹 Navigate to Home with success message
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Home(showSuccess: true)),
    );
  }

  // ================= UI HELPERS =================
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _field(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
