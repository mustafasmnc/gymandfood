import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  getFoodCategoryName(String catId) {
    return FirebaseFirestore.instance
        .collection("food")
        .doc("food_category")
        .collection("food_categories")
        .where("food_category_id", isEqualTo: catId)
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

  getUserInfo(String userId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .snapshots();
  }

  updateUserInfo(String userId, String userName, int userDailyCalorie,
      int userDailyCarb, int userDailyProtein, int userDailyFat) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .update(
          {
            "userName": userName,
            "userDailyCalorie": userDailyCalorie,
            "userDailyCarb": userDailyCarb,
            "userDailyProtein": userDailyProtein,
            "userDailyFat": userDailyFat
          },
        )
        .then((value) => print("UserInfo Data Updated"))
        .catchError((error) => print("Failed to Update UserInfo: $error"));
  }

  Future addFavoriteFood(
      String userId,
      String foodId,
      String foodName,
      String foodPic,
      String foodCal,
      String foodProtein,
      String foodCarb,
      String foodFat) async {
    Map<String, String> foodData = {
      "foodId": foodId,
      "foodName": foodName,
      "foodPic": foodPic,
      "foodCal": foodCal,
      "foodProtein": foodProtein,
      "foodCarb": foodCarb,
      "foodFat": foodFat,
    };

    return await FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('favorite_foods')
        .doc(foodId)
        .set(foodData)
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

  addDailyFood(String userId, String foodId, String foodPic, String foodName,
      String foodCal, String foodProtein, String foodCarb, String foodFat) {
    String nowTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    var nowDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int intfoodCal = int.parse(foodCal);
    int intfoodProtein = int.parse(foodProtein);
    int intfoodCarb = int.parse(foodCarb);
    int intfoodFat = int.parse(foodFat);

    Map<String, dynamic> foodData = {
      "foodId": foodId,
      "foodName": foodName,
      "foodPic": foodPic,
      "foodCal": intfoodCal,
      "foodProtein": intfoodProtein,
      "foodCarb": intfoodCarb,
      "foodFat": intfoodFat,
      "addedTime": nowDateTime
    };

    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('daily_foods')
        .doc(nowTimeStamp)
        .set(foodData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getDailyFoods(String userId) {
    var nowDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('daily_foods')
        .where("addedTime", isEqualTo: nowDateTime)
        .snapshots();
  }

  removeDailyFoods(String userId, String addedFoodId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("daily_foods")
        .doc(addedFoodId)
        .delete();
  }

  Future addExercise(String userId, Map<String, String> exerciseData,
      String addedExerciseId) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("user_exercises")
        .doc(addedExerciseId)
        .get()
        .then((value) {
      if (value.exists == true) {
        FirebaseFirestore.instance
            .collection("user")
            .doc(userId)
            .collection('user_exercises')
            .doc(addedExerciseId)
            .set(exerciseData);
        return "updated";
      } else {
        FirebaseFirestore.instance
            .collection("user")
            .doc(userId)
            .collection('user_exercises')
            .doc(addedExerciseId)
            .set(exerciseData);
        return "added";
      }
    });

    // return await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(userId)
    //     .collection('user_exercises')
    //     .doc(dataId)
    //     .set(exerciseData)
    //     .then((value) => print("User Added"))
    //     .catchError((error) => print("Failed to add user: $error"));
  }

  getAddedExercises(String userId, String dayId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("user_exercises")
        .where("dayNumber", isEqualTo: dayId)
        //.orderBy("exercise_id")
        .snapshots();
  }

  updateAddedExercises(
    String userId,
    String addedExerciseId,
    String exerciseSet,
    String exerciseRepeat,
  ) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection('user_exercises')
        .doc(addedExerciseId)
        .update(
          {"exerciseSet": exerciseSet, "exerciseRepeat": exerciseRepeat},
        )
        .then((value) => print("User Exercises Updated"))
        .catchError(
            (error) => print("Failed to Update User Exercises: $error"));
  }

  removeAddedExercise(String userId, String addedExerciseId) {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("user_exercises")
        .doc(addedExerciseId)
        .delete();
  }
}
