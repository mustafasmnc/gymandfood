import 'package:gymandfood/ui/pages/food_category.dart';

class FoodCategory {
  final String foodCategoryId;
  final String foodCategoryName;
  final String foodCategoryImage;
  final String foodCategoryDesc;

  FoodCategory(
      {this.foodCategoryId,
      this.foodCategoryName,
      this.foodCategoryImage,
      this.foodCategoryDesc});
}

final foodCategories = [
  FoodCategory(
      foodCategoryId: "1",
      foodCategoryName: "Food",
      foodCategoryDesc: "That is Food Desc",
      foodCategoryImage:
          "https://selfgrowth.info/photos/free-food-images-HD/best-food-wallpapers-without-words8426.jpg"),
  FoodCategory(
      foodCategoryId: "2",
      foodCategoryName: "Drink",
      foodCategoryDesc: "That is Drink Desc",
      foodCategoryImage:
          "https://images.squarespace-cdn.com/content/v1/5b4ee1897c93279fa2ecc59e/1568270381325-ZZNWR318V2BECL1EGX9P/ke17ZwdGBToddI8pDm48kOqo7Sx2tkTX1ZpqS4HCQ71Zw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpyqkF6hrF03zgg83QPiQVuTKT-TJ630PzA1k9LbrN44qovtVJc1bPCxzTYeZ2TL2T4/istcoffe-k02G--621x414%40LiveMint.jpg?format=500w"),
  FoodCategory(
      foodCategoryId: "1",
      foodCategoryName: "Food 2",
      foodCategoryDesc: "That is Food 2 Desc",
      foodCategoryImage:
          "https://selfgrowth.info/photos/free-food-images-HD/best-food-wallpapers-without-words8426.jpg"),
  FoodCategory(
      foodCategoryId: "2",
      foodCategoryName: "Drink 2",
      foodCategoryDesc: "That is Drink 2 Desc",
      foodCategoryImage:
          "https://images.squarespace-cdn.com/content/v1/5b4ee1897c93279fa2ecc59e/1568270381325-ZZNWR318V2BECL1EGX9P/ke17ZwdGBToddI8pDm48kOqo7Sx2tkTX1ZpqS4HCQ71Zw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpyqkF6hrF03zgg83QPiQVuTKT-TJ630PzA1k9LbrN44qovtVJc1bPCxzTYeZ2TL2T4/istcoffe-k02G--621x414%40LiveMint.jpg?format=500w"),
];
