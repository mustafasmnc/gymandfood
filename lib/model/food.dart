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
      foodPic:
          "https://imgrosetta.mynet.com.tr/file/12059990/12059990-728xauto.jpg",
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
      foodPic:
          "https://cdn.shopify.com/s/files/1/0956/1562/t/4/assets/slideshow_1.jpg?v=8249725669942539290",
      foodCal: "2",
      foodCarb: "0,09",
      foodProtein: "0,28",
      foodFat: "0,05",
      foodHealth: "4"),
  Food(
      foodId: "12347",
      foodCat: "Food",
      foodName: "Tavuk Göğsü",
      foodDesc:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean at est sit amet nisi sagittis iaculis. Nulla aliquet urna sem, eget pretium orci volutpat non. Vestibulum pellentesque, mi gravida gravida posuere, metus nisi pellentesque nulla, sit amet lobortis elit nunc et est. Curabitur tortor erat, tempor vitae elit eget, pulvinar interdum dui. Curabitur id pretium nunc, ut interdum elit. Vestibulum suscipit magna eu venenatis feugiat. Nulla quis neque eget diam molestie molestie in eu elit. Pellentesque eros dui, lacinia id massa a, mollis vulputate elit. Integer consequat lacus lectus, ut bibendum purus interdum hendrerit. Fusce ullamcorper luctus aliquam. Aliquam feugiat tortor et sem maximus, a congue turpis volutpat.Nam pretium molestie neque, vel maximus sapien dapibus eget. Aenean mollis molestie ligula at maximus. Sed eget dui accumsan, finibus tellus et, aliquet ex. Aliquam sit amet facilisis est, porttitor aliquet nisl. Aliquam ultricies gravida hendrerit. Maecenas ornare neque justo, tempus finibus tortor vestibulum a. Vivamus convallis semper quam. Sed ac orci tellus. Aliquam blandit diam nec arcu laoreet, eu pellentesque magna dapibus. Proin eu blandit est, a feugiat urna. Maecenas quis dolor elementum, eleifend sapien vitae, tempus libero. Nullam nec ex id augue fermentum euismod eget sit amet massa. Fusce augue metus, cursus eget neque quis, interdum pharetra sem. Aliquam sit amet ultricies purus, et sodales nulla. Maecenas ac gravida odio. Maecenas pulvinar nec nisi ac semper.\n\nNam eleifend molestie tortor, vel suscipit justo pulvinar fermentum. In hac habitasse platea dictumst. Donec in arcu vitae mi euismod efficitur sed id sem. Quisque dolor massa, pretium placerat erat ac, consequat ultricies ex. Nulla facilisi. Ut id mi sodales, aliquet nisl non, condimentum lectus. Suspendisse dapibus cursus quam sed fermentum. Maecenas suscipit iaculis erat nec consectetur. Mauris elementum, nisl sed efficitur vestibulum, tellus metus malesuada urna, vitae fringilla lacus dolor sit amet augue. Proin molestie sollicitudin pulvinar. Cras at varius felis. In luctus placerat massa et consectetur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur ac vestibulum tortor, eu mattis nulla.",
      foodSize: "100gr",
      foodPic:
          "https://www.sprinklesandsprouts.com/wp-content/uploads/2020/03/Turkish-Chicken-SQ.jpg",
      foodCal: "195",
      foodCarb: "0",
      foodProtein: "30",
      foodFat: "7,72",
      foodHealth: "5")
];
