class UserModel {
   String userId;
   String userName;
   String userEmail;
   String userPhoto;
   String userType;

  UserModel(
      {this.userId,
      this.userName,
      this.userEmail,
      this.userPhoto,
      this.userType});
}

final user = UserModel(
    userId: "0",
    userName: "Smnc",
    userEmail: "mustafasmnc@gmail.com",
    userPhoto:
        "https://i.pinimg.com/originals/36/43/e7/3643e7e8dab9b88b3972ee1c9f909dea.jpg",
    userType: "Admin");
