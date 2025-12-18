import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addRecipe(Map<String, dynamic> recipeMap) async {
    await FirebaseFirestore.instance.collection("Recipe").add(recipeMap);
  }

  Future addTodaysRecipe(Map<String, dynamic> recipeMap) async {
    await FirebaseFirestore.instance.collection("todays_recipe").add(recipeMap);
  }

  Stream<QuerySnapshot> getRecipes() {
    return FirebaseFirestore.instance
        .collection("Recipe")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getTodaysRecipes() {
    return FirebaseFirestore.instance
        .collection("todays_recipe")
        .orderBy("createdAt", descending: true)
        .get();
  }
}
