import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/Boxes/Box.dart';
import 'package:flutter_todo/model/NotesModel/NotesModel.dart';
import 'package:flutter_todo/resources/constants.dart';
import 'package:flutter_todo/view/detailScreen/DetailScreen.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime date = DateTime.now();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blackColor),
          Positioned(
            top: -120,
            left: 155,
            child: Container(
              height: height * 0.45,
              width: width * 0.45,
              decoration: BoxDecoration(
                  color: AppColors.greenColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: 15,
            right: -30,
            child: Container(
              height: height * 0.4,
              width: width * 0.4,
              decoration: BoxDecoration(
                  color: AppColors.peachColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: 250,
            left: -30,
            child: Container(
              height: height * 0.455,
              width: width * 0.455,
              decoration: BoxDecoration(
                  color: Colors.pinkAccent, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -175,
            left: -30,
            child: Container(
              height: height * 0.455,
              width: width * 0.455,
              decoration: BoxDecoration(
                  color: Colors.purple.shade600, shape: BoxShape.circle),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: -25),
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.blackColor.withOpacity(0.5)),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.blue)),
                    height: height * 0.17,
                    width: width * 0.9,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prioritize your day with a to-do list.",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.white01Color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    DateFormat('EEEE').format(date),
                                    style: GoogleFonts.aBeeZee(
                                        color: AppColors.greenColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat('yMd').format(date),
                                    style: GoogleFonts.poppins(
                                        color: AppColors.white01Color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            FloatingActionButton(
                              elevation: 0,
                              backgroundColor:
                                  AppColors.white01Color.withOpacity(0.5),
                              onPressed: () async {
                                _showDialog();
                              },
                              child: Icon(
                                Icons.add,
                                color: AppColors.blackColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  ValueListenableBuilder<Box<NotesModel>>(
                    valueListenable: Boxes.getData().listenable(),
                    builder: (context, value, _) {
                      var data = value.values.toList().cast<NotesModel>();
                      return data.length != 0
                          ? Container(
                              color: Colors.transparent,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 85,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      new DetailScreen(
                                                    title: data[index].title,
                                                    description:
                                                        data[index].description,
                                                    deleteitem: data[index],
                                                  ),
                                                ));
                                          },
                                          child: Card(
                                              color: AppColors.LightblackColor
                                                  .withOpacity(0.4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      // decoration: BoxDecoration(
                                                      //     color:
                                                      //         AppColors.greenColor),
                                                      width: 300,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data[index]
                                                                .title
                                                                .toString(),
                                                            style: GoogleFonts.aBeeZee(
                                                                color: AppColors
                                                                    .white01Color,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            child: Text(
                                                              data[index]
                                                                  .description
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  color: AppColors
                                                                      .white01Color
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              delete(
                                                                  data[index]);
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: AppColors
                                                                  .white01Color,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              _editDialog(
                                                                  data[index],
                                                                  data[index]
                                                                      .title
                                                                      .toString(),
                                                                  data[index]
                                                                      .description
                                                                      .toString());
                                                            },
                                                            child: Icon(
                                                              Icons.edit,
                                                              color: AppColors
                                                                  .white01Color,
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: height * 0.75,
                                width: width,
                                child: Center(
                                  child: Text(
                                    "ADD SOME NOTES NOW",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.white01Color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editDialog(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.blackColor,
          title: Text(
            "Edit NOTES",
            style: GoogleFonts.aBeeZee(color: AppColors.white01Color),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      // hintStyle: TextStyle(color: AppColors.white01Color),
                      hintText: "Enter Title",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Enter Description",
                      // hintStyle: TextStyle(color: AppColors.white01Color),
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  notesModel.title = titleController.text.toString();
                  notesModel.description =
                      descriptionController.text.toString();
                  notesModel.save();
                  titleController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text(
                  "Edit",
                  style: GoogleFonts.poppins(),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(),
                )),
          ],
        );
      },
    );
  }

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.blackColor,
          title: Text(
            "Add NOTES",
            style: GoogleFonts.aBeeZee(color: AppColors.white01Color),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white01Color.withOpacity(0.6),
                      hintText: "Enter Title",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white01Color.withOpacity(0.6),
                      hintText: "Enter Description",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  // this is how we add data to hive
                  final data = NotesModel(
                      description: descriptionController.text,
                      title: titleController.text);
                  final box = Boxes.getData();
                  box.add(data);
                  data.save();
                  print(box);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Add",
                  style: GoogleFonts.poppins(),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(),
                )),
          ],
        );
      },
    );
  }
}

void delete(NotesModel notesModel) async {
  await notesModel.delete();
}
