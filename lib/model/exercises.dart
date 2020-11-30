class Exercise {
  final String exerciseId,
      exerciseName,
      exercisePic,
      exerciseMuscle,
      exerciseMuscleId,
      exerciseDesc;

  Exercise(
      {this.exerciseId,
      this.exerciseName,
      this.exercisePic,
      this.exerciseMuscle,
      this.exerciseMuscleId,
      this.exerciseDesc});
}

final exercises = [
  Exercise(
      exerciseId: "1",
      exerciseName: "Barbell Bench Press",
      exerciseDesc:
          "You can generate the most power with barbell lifts, so the standard barbell bench allows you to move the most weight. It's also an easier lift to control than pressing with heavy dumbbells. The exercise is easy to spot and relatively easy to learn (if not master), There are plenty of bench-press programs you can follow to increase your strength.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-1-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "2",
      exerciseName: "Flat Bench Dumbbell Press",
      exerciseDesc:
          "With dumbbells, each side of your body must work independently, which recruits more stabilizer muscles; dumbbells are harder to control than a barbell. Dumbbells also allow for a longer range of motion than the barbell bench press, both at the bottom and top of the movement. Flat dumbbell presses allow you to hoist a fairly heavy weight, and they make for a good alternative if you've been stuck on the barbell bench for ages.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-2-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "3",
      exerciseName: "Low-Incline Barbell Bench Press",
      exerciseDesc:
          "Many benches are fixed at a very steep angle, which requires a larger contribution from the front delts than the chest to move the weight.[2] If possible, go for a less-steep incline to hit the upper pecs without as much stress on the delts. You can also easily do low-incline benches with an adjustable bench on the Smith machine.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-3-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "4",
      exerciseName: "Seated Machine Chest Press",
      exerciseDesc:
          "Free-weight pressing moves on a flat bench are great, but the machine press has some unique benefits. For one, it's easier to slow down the repetition, both in the concentric and eccentric phases. Stack-loaded machines are also great for quickly doing dropsets.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-4-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "5",
      exerciseName: "Incline Dumbbell Press",
      exerciseDesc:
          "Dumbbell presses make everybody's top 10 list, but with an adjustable bench you can do a number of things you can't with a fixed bench. Our favorite: changing the angle of the incline from one set to the next, or from one workout to the next. Hitting a muscle from varying degrees of incline angles builds it more thoroughly.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-5-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "6",
      exerciseName: "Pec-Deck Machine",
      exerciseDesc:
          "Chest flyes are hard for many trainees to learn with dumbbells or cables because the arms need to be locked in a slightly bent position for the duration of the exercise. Luckily, the pec deck simplifies things because it allows you to work in only one pathway. So, this exercise is a great movement teacher, and you can go for a great pump without having to balance any weights.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-8-700xh.jpg",
      exerciseMuscle: "Chest",
      exerciseMuscleId: "1"),
  Exercise(
      exerciseId: "7",
      exerciseName: "Bent-Over Barbell Row",
      exerciseDesc:
          "EMG research has suggested that hitting bent-over barbell rows will work the larger muscle groups of the upper and lower back equally, making this a great overall back builder. Like the deadlift, this is another technical move that requires excellent form but rewards you with a ton of muscle.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/june/10-best-muscle-building-back-exercises-v2-2-700xh.jpg",
      exerciseMuscle: "Back",
      exerciseMuscleId: "2"),
  Exercise(
      exerciseId: "8",
      exerciseName: "Wide-Grip Pull-Up",
      exerciseDesc:
          "It's always a good idea to have an overhead pulling movement in your back routine, and the pull-up is one of the best. Wide-grip pull-ups are excellent for putting emphasis on the upper lats. A closer grip may allow for a longer range of motion, but it may be possible to load the wide-grip pull-up to a greater degree because of an optimized starting joint position. The biggest challenge here for most trainers is training to failure in the right rep range for growth, which is 8-12.\n\nIf you do pull-ups early in your workout, you might have to add a weighted belt. Of course, if you find them difficult, you can always use an assisted pull-up machine or a good spotter, or switch to the wide-grip pull-down, which is a solid substitute. If your shoulders are healthy, pulling behind the head is okay.\n\nGood form is extremely important here. In the starting position, the scapula should be retracted—pull your shoulder blades down and toward each other—prior to initiating the pull.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/june/10-best-muscle-building-back-exercises-v2-3-700xh.jpg",
      exerciseMuscle: "Back",
      exerciseMuscleId: "2"),
  Exercise(
      exerciseId: "9",
      exerciseName: "Standing T-Bar Row",
      exerciseDesc:
          "We selected the T-bar row over a chest-supported version because you can pile on much more weight here, even though that typically translates into a bit of cheating through the knees and hips. For some, maintaining a flat back can be challenging, in which case the supported version is a better choice.\n\nThese aren't squats, so keep your legs locked in a bent angle throughout. You also typically have a choice of hand positions and width. A wider grip will put more emphasis on the lats, while a neutral grip will better target the middle back (rhomboids, teres, and traps). This exercise is probably one of the easier rows to spot.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/june/10-best-muscle-building-back-exercises-v2-4-700xh.jpg",
      exerciseMuscle: "Back",
      exerciseMuscleId: "2"),
  Exercise(
      exerciseId: "10",
      exerciseName: "Close-Grip Pull-Down",
      exerciseDesc:
          "Since we've already covered the wide-grip pull-up, the wide-grip pull-down is too similar, so we opted for the close-grip handle for our pull-down selection. EMG research suggests that use of a close neutral grip activates the lats similarly to a regular grip, so you're not missing out on any muscle fibers. As mentioned earlier with pull-ups, a closer grip does allow for a longer range of motion and increased time under tension for the lats, which is great for building muscle.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/june/10-best-muscle-building-back-exercises-v2-6-700xh.jpg",
      exerciseMuscle: "Back",
      exerciseMuscleId: "2"),
  Exercise(
      exerciseId: "11",
      exerciseName: "Single-Arm Dumbbell Row",
      exerciseDesc:
          "This is a great unilateral exercise—each side works independently—that allows you to move a lot of weight. You'll get greater range of motion when training unilaterally, and you won't be restrained if your weaker side fails first. You may also be better able to support your lower back—which may have taken plenty of punishment by now—when placing one hand on a bench. Allowing a slight degree of rotation of the trunk may engage a greater degree of \"core\" musculature, as well.",
      exercisePic:
          "https://www.bodybuilding.com/images/2016/june/10-best-muscle-building-back-exercises-v2-7-700xh.jpg",
      exerciseMuscle: "Back",
      exerciseMuscleId: "2"),
  Exercise(
      exerciseId: "12",
      exerciseName: "Barbell Overhead Shoulder Press",
      exerciseDesc:
          "A barbell overhead shoulder press (aka barbell standing shoulder press) works not just your shoulders, but most of your body. That makes it a terrific core strengthener and mass builder, among other things. To start, put your feet at shoulder-width, and tighten your core as you hold a barbell at your shoulders, palms facing forward. Next, push the bar upward and squeeze your shoulder blades together at the peak. Lower steadily and carefully.",
      exercisePic:
          "https://manofmany.com/wp-content/uploads/2019/03/10-Best-Shoulder-Exercises-for-Men-Barbell-Overhead-Shoulder-Press-1.jpg",
      exerciseMuscle: "Shoulder",
      exerciseMuscleId: "3"),
  Exercise(
      exerciseId: "13",
      exerciseName: "Seated Dumbbell Shoulder Press",
      exerciseDesc:
          "A proper deltoid workout simply isn’t complete without the seated dumbbell shoulder press. In fact, some say this exercise routine is an entire deltoid regimen unto itself, targeting the anterior, lateral, and posterior deltoid muscles (with an emphasis on the middle delts). Meanwhile, lifting two separate dumbbells (as opposed to using a machine) prevents you from using one side of your body over the other, thereby retaining firmer balance and distribution. Naturally, a fair amount of coordination is required to pull this one off, especially when you increase the weights.\n\nTo perform a seated dumbbell shoulder press, sit on a low-back bench and hold a dumbbell in each hand at the shoulder level, palms facing forward. Keeping your head and spine perfectly straight, lift the dumbbells overhead toward one another, stopping just short of having them touch at the top. Hold the position for a few seconds and then carefully reverse course. Repeat.",
      exercisePic:
          "https://manofmany.com/wp-content/uploads/2019/03/10-Best-Shoulder-Exercises-for-Men-Seated-Dumbbell-Shoulder-Press.jpg",
      exerciseMuscle: "Shoulder",
      exerciseMuscleId: "3"),
  Exercise(
      exerciseId: "14",
      exerciseName: "Front Raise",
      exerciseDesc:
          "You can use either a weight plate or barbell for this shoulder exercise, which targets the anterior delts. No matter what you decide to use, prepare for a seriously intense workout that brings no shortage of healthy pain. For that reason, don’t max out on the weight, as it will quickly turn healthy pain into unhealthy injury.\n\nTo execute, keep your hands at hip height as you hold the weight in front of you. Your feet should be even with your shoulders and your core should be tight. Next, retract your shoulder blades and keep your arms straight as you lift the weight to shoulder level. Breathe steadily and lower the weight carefully. Repeat.",
      exercisePic:
          "https://manofmany.com/wp-content/uploads/2019/03/10-Best-Shoulder-Exercises-for-Men-Front-Raise.jpg",
      exerciseMuscle: "Shoulder",
      exerciseMuscleId: "3"),
  Exercise(
      exerciseId: "14",
      exerciseName: "Bent-Over Dumbbell Lateral Raise",
      exerciseDesc:
          "This wildly effective shoulder exercise targets your middle deltoids, though it also builds upon your overall physique. You can perform it in either a standing (bent-over) or seated position. Start with a dumbbell in each hand, keeping your chest up, your back flat, your knees slightly bent, and your eyes focussed toward a fixed point on the floor. Now, bend over until your core is basically parallel with the ground, and hang the dumbbells directly underneath you, all while keeping your elbows in a slightly bent position. Next, raise both dumbbells up and out to your sides, forming an arc until your upper arms are even with your torso. Take a brief pause at the top before lowering the dumbbells back into starting position. Repeat.",
      exercisePic:
          "https://manofmany.com/wp-content/uploads/2019/03/10-Best-Shoulder-Exercises-for-Men-Bent-over-dumbbell-lateral-raise.jpg",
      exerciseMuscle: "Shoulder",
      exerciseMuscleId: "3"),
  Exercise(
      exerciseId: "15",
      exerciseName: "Dumbbell Lateral Raise",
      exerciseDesc:
          "If you prefer a more traditional lateral raise, look no further than this one here. It likewise targets the middle deltoids and works wonders when executed properly. Start in the standing position, keeping your feet shoulder-width apart, your abs tight, your chest up, your head straight, and your shoulders pinched. Hold the dumbbells at either side, retaining a neutral grip.\n\nNow, here comes the hard part. Using just your shoulders and arms, raise the dumbbells a notch above shoulder level, and hold for a few seconds. Lower the dumbbells back to the starting position, and repeat. Your elbows and hands should be moving together in harmony the entire time, and you should be maintaining a neutral, balanced position. If you find that your core or neck is shifting as you perform each rep (i.e. you’re utilising your body’s momentum), lower the weight accordingly.",
      exercisePic:
          "https://manofmany.com/wp-content/uploads/2019/03/10-Best-Shoulder-Exercises-for-Men-Dumbbell-Lateral-Raise.jpg",
      exerciseMuscle: "Shoulder",
      exerciseMuscleId: "3"),
  Exercise(
      exerciseId: "16",
      exerciseName: "Hammer Curl",
      exerciseDesc:
          "Hold a dumbbell in each hand with palms facing your sides and arms extended straight down. Keeping your upper arms against your sides, curl both weights at the same time, minimizing momentum used during the curl.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_hammercheatcurl.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Biceps",
      exerciseMuscleId: "4"),
  Exercise(
      exerciseId: "17",
      exerciseName: "Dip",
      exerciseDesc:
          "Use dip bars, if available, or place your palms on a bench, chair, or on the floor as you extend your legs in front of you. Lower your body until your upper arms are parallel to the floor, but no lower. Extend your elbows to come up.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_dips_0.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Triceps",
      exerciseMuscleId: "5"),
  Exercise(
      exerciseId: "18",
      exerciseName: "Neutral-Grip Triceps Extension",
      exerciseDesc:
          "Lie back on a bench or the floor holding a dumbbell in each hand with palms facing each other. Press the weights over your chest, then bend your elbows to lower the weights toward your face until you feel a stretch in your triceps. Extend your elbows. Keep your elbows facing the ceiling the entire set.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/30-best-arm-exercises-neutral-grip-tricep-extension.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Triceps",
      exerciseMuscleId: "5"),
  Exercise(
      exerciseId: "19",
      exerciseName: "Behind-the-Back Cable Curl",
      exerciseDesc:
          "Attach a D-handle to the low pulley of a cable machine, grasp the handle in your left hand, and step forward (away from the machine) until there’s tension on the cable and your arm is drawn slightly behind your body. Stagger your feet so your right leg is in front. Curl the handle but do not allow your elbow to point forward.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_behindthebackcablecurl.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Biceps",
      exerciseMuscleId: "4"),
  Exercise(
      exerciseId: "20",
      exerciseName: "EZ-Bar Preacher Curl",
      exerciseDesc:
          "Sit at a preacher bench and adjust the height so that your armpits touch the top of the bench. Grasp an EZ-curl bar at shoulder width with arms extended (but allow a slight bend at the elbows). Curl the bar, keeping the backs of your arms against the bench. Take three seconds to lower the bar back down.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_ezbarpreachercurl.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Biceps",
      exerciseMuscleId: "4"),
  Exercise(
      exerciseId: "21",
      exerciseName: "Wide-Grip Curl",
      exerciseDesc:
          "Grasp the bar with hands wider than shoulder width—if you’re using an Olympic bar, your pinkies should be on the outside knurling. Perform curls.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/30-best-arm-exercises-wide-grip-curl.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Biceps",
      exerciseMuscleId: "4"),
  Exercise(
      exerciseId: "22",
      exerciseName: "Pullover/Triceps Extension",
      exerciseDesc:
          "Hold the bar with an overhand, shoulder-width grip while lying on a flat bench. Press the bar toward the ceiling and then reach it back over your head while bending your elbows until you feel a stretch in your lats. Then pull the bar back over your chest and extend your elbows. That’s one rep.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/30-best-arm-exercises-pullover-tricep-extension.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Triceps",
      exerciseMuscleId: "5"),
  Exercise(
      exerciseId: "23",
      exerciseName: "Underhand Kickback",
      exerciseDesc:
          "Stand holding a dumbbell in each hand and bend your hips back, lowering your torso until it’s almost parallel to the floor. Turn your palms to face in front of you and, keeping your upper arms against your sides, extend your elbows until your arms are parallel to your torso.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_dbkickback.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Triceps",
      exerciseMuscleId: "5"),
  Exercise(
      exerciseId: "24",
      exerciseName: "Squat",
      exerciseDesc:
          "In a squat rack or cage, grasp the bar as far apart as is comfortable and step under it. Place it on your lower traps, squeeze your shoulder blades together, push your elbows up and nudge the bar out of the rack. Take a step or two back and stand with your feet at shoulder width and your toes turned slightly out. Take a deep breath and bend your hips back, then bend your knees to lower your body as far as you can without losing the arch in your lower back. Push your knees out as you descend. Drive vertically with your hips to come back up, continuing to push your knees out.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/squat_main_1.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "25",
      exerciseName: "Bulgarian Split Squat",
      exerciseDesc:
          "Stand lunge-length in front of a bench. Hold a dumbbell in each hand and rest the top of your left foot on the bench behind you. Lower your body until your rear knee nearly touches the floor and your front thigh is parallel to the floor. Single-leg training can yield serious strength gains. ",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_bulgariansplitsquat.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "26",
      exerciseName: "Deadlift",
      exerciseDesc:
          "Stand straight up with feet hip-width apart and shins one inch away from the bar. Grip the bar with a double pronated or reverse grip, bend knees and push them into your straight arms. Bring your chest up as much as possible and look straight ahead. Keeping your back flat, extend your hips to stand up, pulling the bar up along your legs to lockout.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_deadlift_1.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "27",
      exerciseName: "Leg Press",
      exerciseDesc:
          "Adjust the seat of the machine so that you can sit comfortably with your hips beneath your knees and your knees in line with your feet. Remove the safeties and lower your knees toward your chest until they’re bent 90 degrees and then press back up. Be careful not to go too low or you risk your lower back coming off the seat (which can cause injury).",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_legpress.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "28",
      exerciseName: "Walking Lunge",
      exerciseDesc:
          "Stand with your feet hip width, holding a dumbbell in each hand. Step forward with one leg and lower your body until your rear knee nearly touches the floor and your front thigh is parallel to the floor. Step forward with your rear leg to perform the next rep.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/_main_walking-lunge.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "29",
      exerciseName: "Seated Calf Raise",
      exerciseDesc:
          "Use a seated calf raise machine, or sit on a bench and rest the balls of your feet on a block or step (and hold dumbbells on your thighs for resistance). Perform a calf raise as described at left, but with hips and knees bent 90 degrees.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/mf/seated_calf_raise-the-30-best-legs-exercises-of-all-time.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Leg",
      exerciseMuscleId: "6"),
  Exercise(
      exerciseId: "30",
      exerciseName: "Ab Wheel Rollout",
      exerciseDesc:
          "Kneel on the floor and hold an ab wheel beneath your shoulders. Brace your abs and roll the wheel forward until you feel you’re about to lose tension in your core and your hips might sag. Roll yourself back to start. Do as many reps as you can with perfect form and end the set when you think you might break form.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/2018/03/abwheelrollout.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Abs",
      exerciseMuscleId: "7"),
  Exercise(
      exerciseId: "31",
      exerciseName: "Dip/Leg Raise Combo",
      exerciseDesc:
          "Suspend yourself over the parallel bars at a dip station. Bend your knees slightly and raise your legs in front of you until they’re parallel to the floor.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/2018/03/30-best-ab-exercises-dip-leg-raise.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Abs",
      exerciseMuscleId: "7"),
  Exercise(
      exerciseId: "32",
      exerciseName: "Leg Raise",
      exerciseDesc:
          "Lie on the floor and hold onto a bench or the legs of a heavy chair for support. Keep your legs straight and raise them up until they’re vertical. Lower back down, but stop just short of the floor to keep tension on your abs before the next rep.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/2018/03/legraise.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Abs",
      exerciseMuscleId: "7"),
  Exercise(
      exerciseId: "33",
      exerciseName: "Plank",
      exerciseDesc:
          "Get into pushup position and bend your elbows to lower your forearms to the floor. Hold the position with abs braced.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/2018/03/plank.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Abs",
      exerciseMuscleId: "7"),
  Exercise(
      exerciseId: "34",
      exerciseName: "Side Plank",
      exerciseDesc:
          "Lie on your left side resting your left forearm on the floor for support. Raise your hips up so your body forms a straight line and brace your abs—your weight should be on your left forearm and the edge of your left foot. Hold the position with abs braced.",
      exercisePic:
          "https://www.mensjournal.com/wp-content/uploads/2018/03/30-best-ab-workouts-side-plank.jpg?w=700&quality=86&strip=all",
      exerciseMuscle: "Abs",
      exerciseMuscleId: "7"),
];
