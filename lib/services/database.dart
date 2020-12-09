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

  
}
