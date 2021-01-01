import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // getFoodCategory() async {
  //   return await FirebaseFirestore.instance
  //       .collection("food")
  //       .doc("food_category")
  //       .collection("food_categories")
  //       .get();
  // }

  getFoodCategorySnapshot() {
    return FirebaseFirestore.instance
        .collection("food")
        .doc("food_category")
        .collection("food_categories")
        .snapshots();
  }

  getFilteredFoods(String foodCatId) {
    return FirebaseFirestore.instance
        .collection("food")
        .doc("food_list")
        .collection("food_info")
        .where("food_cat_id", isEqualTo: foodCatId)
        .snapshots();
  }

  getFoodDetail(String foodId) {
    return FirebaseFirestore.instance
        .collection("food")
        .doc("food_list")
        .collection("food_info")
        .where("food_id", isEqualTo: foodId)
        .snapshots();
  }

  getBodyMuscles() {
    return FirebaseFirestore.instance
        .collection("exercise")
        .doc("body_muscles")
        .collection("body_muscle_info")
        .orderBy("muscle_id")
        .snapshots();
  }

  getExercises(String muscleId) {
    return FirebaseFirestore.instance
        .collection("exercise")
        .doc("exercise_list")
        .collection("exercise_info")
        .where("exercise_muscle_id", isEqualTo: muscleId)
        //.orderBy("exercise_id")
        .snapshots();
  }

  getUserName(String userId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .snapshots();

    //  .then((value) {
    // print("VALUEE: " + value.data()["userName"]);
    // setState(() {
    //   userName = value.data()["userName"];
    // });
    //});
  }

  Future addFavoriteFood(
      String userId,
      String foodId,
      String foodName,
      String foodPic,
      String foodCal,
      String foodProtein,
      String foodFat) async {
    Map<String, String> userData = {
      "foodId": foodId,
      "foodName": foodName,
      "foodPic": foodPic,
      "foodCal": foodCal,
      "foodProtein": foodProtein,
      "foodFat": foodFat,
    };

    return await FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('favorite_foods')
        .doc(foodId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getFavoriteFoods(String userId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("favorite_foods")
        .snapshots();
  }

  removeFavoriteFood(String userId, String foodId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("favorite_foods")
        .doc(foodId)
        .delete();
  }
}
