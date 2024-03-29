import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/food_list.dart';
import 'package:gymandfood/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

String usertype;

DatabaseService databaseService = DatabaseService();

Future<String> getUserType() async {
  String userType;
  await FirebaseFirestore.instance
      .collection("user")
      .doc(userId)
      .get()
      .then((value) {
    userType = value.data()['userType'];
    usertype = value.data()['userType'];
  });
  return Future.value(userType.toString());
}

class FoodCategoryPage extends StatefulWidget {
  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

String userId;

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseService.getFoodCategorySnapshot(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            try {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                //child: Expanded(
                //child: RefreshIndicator(
                //  key: _refreshIndicatorKey,
                // onRefresh: refreshList,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot fcs = snapshot.data.docs[index];
                      return CategoryTile(
                        foodCategoryDocId: fcs.id,
                        foodCategoryImg: fcs["food_category_pic"],
                        foodCategoryTitle: fcs["food_category_name"],
                        foodCategoryDesc: fcs["food_category_desc"],
                        foodCategoryId: fcs["food_category_id"],
                      );
                    }),
                //),
                //),
              );
            } catch (e) {
              print(e);
              return Center(
                child: Text("Error"),
              );
            }
          }
        },
      ),
      floatingActionButton: FutureBuilder(
          future: getUserType(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data == "admin"
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFoodCategory()));
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                  )
                : Text("");
          }),
    );
  }
}

class CategoryTile extends StatefulWidget {
  final String foodCategoryDocId;
  final String foodCategoryImg;
  final String foodCategoryTitle;
  final String foodCategoryDesc;
  final String foodCategoryId;

  const CategoryTile(
      {@required this.foodCategoryImg,
      @required this.foodCategoryTitle,
      @required this.foodCategoryDesc,
      @required this.foodCategoryId,
      @required this.foodCategoryDocId});
  // final FoodCategory foodCategory;

  // const CategoryTile({Key key, this.foodCategory}) : super(key: key);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      height: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.foodCategoryImg != null
                  ? widget.foodCategoryImg
                  : "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/food-loading-animation.gif?alt=media&token=623496c1-607c-4767-9170-47ce71755cc5",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodList(
                            foodCatId: widget.foodCategoryId,
                          )));
            },
            onLongPress: () {
              usertype == "admin"
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodCategoryEdit(
                                foodCategoryDocId: widget.foodCategoryDocId,
                              )))
                  : print("Not Admin..!!");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.foodCategoryTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.foodCategoryDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FoodCategoryEdit extends StatefulWidget {
  final String foodCategoryDocId;

  const FoodCategoryEdit({this.foodCategoryDocId});
  @override
  _FoodCategoryEditState createState() => _FoodCategoryEditState();
}

class _FoodCategoryEditState extends State<FoodCategoryEdit> {
  String textCatName, textCatDesc;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  File imgFile;
  final imgPicker = ImagePicker();

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<String> _pickSaveImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
    var pieces = imgFile.path.split('/');
    Reference ref = storage.ref().child('uploads/${pieces[pieces.length - 1]}');
    UploadTask uploadTask = ref.putFile(imgFile);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      print("FILE PAThhh: $url");
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  updateCat(String catPic) async {
    if (imgFile != null) {
      FirebaseStorage storage = FirebaseStorage.instance;

      String downloadUrl;

      var pieces = imgFile.path.split('/');
      Reference ref =
          storage.ref().child('uploads/${pieces[pieces.length - 1]}');
      UploadTask uploadTask = ref.putFile(imgFile);
      uploadTask.whenComplete(() async {
        downloadUrl = await ref.getDownloadURL();

        if (_formKey.currentState.validate()) {
          databaseService
              .updateFoodCategory(
                  docId: widget.foodCategoryDocId,
                  foodCatPic: downloadUrl,
                  foodCatName: textCatName,
                  foodCatDesc: textCatDesc)
              .then((value) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: Theme.of(context).primaryColor,
                content: Text(
                  "Category Updated",
                  textAlign: TextAlign.center,
                ),
              ),
            );

            new Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.of(context).pop();
            });
          }).catchError((error) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(microseconds: 3000),
                backgroundColor: Colors.red,
                content: Text(
                  "Failed to Update Category: $error",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          });
        }
      }).catchError((onError) {
        print(onError);
      });
    } else {
      if (_formKey.currentState.validate()) {
        databaseService
            .updateFoodCategory(
                docId: widget.foodCategoryDocId,
                foodCatPic: catPic,
                foodCatName: textCatName,
                foodCatDesc: textCatDesc)
            .then((value) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "Category Updated",
                textAlign: TextAlign.center,
              ),
            ),
          );

          new Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });
        }).catchError((error) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(microseconds: 3000),
              backgroundColor: Colors.red,
              content: Text(
                "Failed to Update Category: $error",
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: StreamBuilder(
                    stream: databaseService
                        .getFoodCategoryInfo(widget.foodCategoryDocId),
                    builder: (context, snapshotFoodCat) {
                      if (snapshotFoodCat.hasError) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        try {
                          return Column(
                            children: [
                              imgFile == null
                                  ? Image.network(
                                      snapshotFoodCat
                                                  .data["food_category_pic"] !=
                                              null
                                          ? snapshotFoodCat
                                              .data["food_category_pic"]
                                          : "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/food-loading-animation.gif?alt=media&token=623496c1-607c-4767-9170-47ce71755cc5",
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      imgFile,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                              GestureDetector(
                                onTap: () => showOptionsDialog(context),
                                child: Icon(Icons.add_a_photo),
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Category Name",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  TextFormField(
                                    initialValue: snapshotFoodCat
                                        .data["food_category_name"]
                                        .toString(),
                                    onChanged: (value) {
                                      textCatName = value;
                                    },
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Enter category name"
                                          : null;
                                    },
                                    maxLength: 25,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text("Category Desc",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  TextFormField(
                                    initialValue: snapshotFoodCat
                                        .data["food_category_desc"]
                                        .toString(),
                                    onChanged: (value) {
                                      textCatDesc = value;
                                    },
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Enter category description"
                                          : null;
                                    },
                                    maxLength: 200,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 120,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        "CANCEL",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      if (textCatName == null)
                                        textCatName = snapshotFoodCat
                                            .data["food_category_name"]
                                            .toString();
                                      if (textCatDesc == null)
                                        textCatDesc = snapshotFoodCat
                                            .data["food_category_desc"]
                                            .toString();
                                      updateCat(snapshotFoodCat
                                          .data["food_category_pic"]);
                                    },
                                    child: Container(
                                      width: 120,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        "UPDATE",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        } catch (e) {
                          print(e);
                          return Center(
                            child: Text("Error"),
                          );
                        }
                      }
                    })),
          ),
        ),
      ),
    );
  }
}

class AddFoodCategory extends StatefulWidget {
  @override
  _AddFoodCategoryState createState() => _AddFoodCategoryState();
}

class _AddFoodCategoryState extends State<AddFoodCategory> {
  String textCatName, textCatDesc;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  File imgFile;
  final imgPicker = ImagePicker();

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  addCat() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    String downloadUrl;

    var pieces = imgFile.path.split('/');
    Reference ref = storage.ref().child('uploads/${pieces[pieces.length - 1]}');
    UploadTask uploadTask = ref.putFile(imgFile);
    uploadTask.whenComplete(() async {
      downloadUrl = await ref.getDownloadURL();

      if (_formKey.currentState.validate()) {
        databaseService
            .addFoodCategory(
                foodCatPic: downloadUrl,
                foodCatName: textCatName,
                foodCatDesc: textCatDesc)
            .then((value) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "Category Updated",
                textAlign: TextAlign.center,
              ),
            ),
          );

          new Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });
        }).catchError((error) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(microseconds: 3000),
              backgroundColor: Colors.red,
              content: Text(
                "Failed to Update Category: $error",
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  children: [
                    imgFile == null
                        ? Image.network(
                            imgFile == null
                                ? "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/food-loading-animation.gif?alt=media&token=623496c1-607c-4767-9170-47ce71755cc5"
                                : imgFile,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            imgFile,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                    GestureDetector(
                      onTap: () => showOptionsDialog(context),
                      child: Icon(Icons.add_a_photo),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category Name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        TextFormField(
                          onChanged: (value) {
                            textCatName = value;
                          },
                          validator: (value) {
                            return value.isEmpty ? "Enter category name" : null;
                          },
                          maxLength: 25,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text("Category Desc",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        TextFormField(
                          onChanged: (value) {
                            textCatDesc = value;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Enter category description"
                                : null;
                          },
                          maxLength: 50,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: submitButton(
                              context: context,
                              buttonWith: 120,
                              text: "CANCEL",
                              buttoncolor: Colors.red),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            addCat();
                          },
                          child: submitButton(
                              context: context, buttonWith: 120, text: "ADD"),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
