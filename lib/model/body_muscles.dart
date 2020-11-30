class BodyMuscles {
  final String bodyMuscleId;
  final String bodyMuscleName;
  final String bodyMuscleImage;
  final String bodyMuscleDesc;

  BodyMuscles(
      {this.bodyMuscleId,
      this.bodyMuscleName,
      this.bodyMuscleImage,
      this.bodyMuscleDesc});
}

final bodyMuscles = [
  BodyMuscles(
      bodyMuscleId: "1",
      bodyMuscleName: "Chest",
      bodyMuscleImage: "assets/chest.jpg",
      bodyMuscleDesc: "Chest Desc"),
  BodyMuscles(
      bodyMuscleId: "2",
      bodyMuscleName: "Back",
      bodyMuscleImage: "assets/back1.jpg",
      bodyMuscleDesc: "Back Desc"),
  BodyMuscles(
      bodyMuscleId: "3",
      bodyMuscleName: "Shoulder",
      bodyMuscleImage: "assets/shoulder.jpg",
      bodyMuscleDesc: "Shoulder Desc"),
  BodyMuscles(
      bodyMuscleId: "4",
      bodyMuscleName: "Biceps",
      bodyMuscleImage: "assets/biceps.jpg",
      bodyMuscleDesc: "Biceps Desc"),
  BodyMuscles(
      bodyMuscleId: "5",
      bodyMuscleName: "Triceps",
      bodyMuscleImage: "assets/triceps.jpg",
      bodyMuscleDesc: "Triceps Desc"),
  BodyMuscles(
      bodyMuscleId: "6",
      bodyMuscleName: "Leg",
      bodyMuscleImage: "assets/leg1.jpg",
      bodyMuscleDesc: "Leg Desc"),
  BodyMuscles(
      bodyMuscleId: "7",
      bodyMuscleName: "Abs",
      bodyMuscleImage: "assets/abdominal.jpg",
      bodyMuscleDesc: "Abs Desc"),
];
