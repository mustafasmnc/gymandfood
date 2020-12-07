import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getFoodCategory() async {
    return await FirebaseFirestore.instance
        .collection("food")
        .doc("food_category")
        .collection("food_categories")
        .get();
  }

  getFoodCategorySnapshot() {
    return FirebaseFirestore.instance
        .collection("food")
        .doc("food_category")
        .collection("food_categories")
        .snapshots();
  }
}
