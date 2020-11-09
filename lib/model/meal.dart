class Food {
  final String foodId,
      foodCat,
      foodName,
      foodDesc,
      foodSize,
      foodPic,
      foodCal,
      foodCarb,
      foodProtein,
      foodFat,
      foodHealth;

  Food(
      {this.foodId,
      this.foodCat,
      this.foodName,
      this.foodDesc,
      this.foodSize,
      this.foodPic,
      this.foodCal,
      this.foodCarb,
      this.foodProtein,
      this.foodFat,
      this.foodHealth});
}

final foods = [
  Food(
      foodId: "12345",
      foodCat: "Food",
      foodName: "Pirinç Pilavı",
      foodDesc: "ASDASDASDASDASDASD",
      foodSize: "100gr",
      foodPic: "https://imgrosetta.mynet.com.tr/file/12059990/12059990-728xauto.jpg",
      foodCal: "167",
      foodCarb: "27",
      foodProtein: "2,7",
      foodFat: "5",
      foodHealth: "4"),
  Food(
      foodId: "12346",
      foodCat: "Drink",
      foodName: "Kahve",
      foodDesc: "QWEQWEQWEQWEQWE",
      foodSize: "250ml",
      foodPic: "https://cdn.shopify.com/s/files/1/0956/1562/t/4/assets/slideshow_1.jpg?v=8249725669942539290",
      foodCal: "2",
      foodCarb: "0,09",
      foodProtein: "0,28",
      foodFat: "0,05",
      foodHealth: "4"),
  Food(
      foodId: "12347",
      foodCat: "Food",
      foodName: "Tavuk Göğsü",
      foodDesc: "ZXCZXCZXCZXCZXC",
      foodSize: "100gr",
      foodPic: "https://www.sprinklesandsprouts.com/wp-content/uploads/2020/03/Turkish-Chicken-SQ.jpg",
      foodCal: "195",
      foodCarb: "0",
      foodProtein: "30",
      foodFat: "7,72",
      foodHealth: "5")
];
