import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_todo/model/NotesModel/NotesModel.dart';
import 'package:flutter_todo/resources/constants.dart';
import 'package:flutter_todo/view/HomeScreen/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final NotesModel deleteitem;
  const DetailScreen(
      {required this.description,
      required this.title,
      required this.deleteitem});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.65,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                      color: AppColors.LightblackColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Center(
                            child: Text(
                          widget.title,
                          style: GoogleFonts.aBeeZee(
                              color: AppColors.whiteColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.blue,
                            child: Center(
                                child: Text(
                              widget.description,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.LightblackColor,
                        shape: CircleBorder(eccentricity: 0.6)),
                    onPressed: () {
                      Navigator.pop(context);
                      delete(widget.deleteitem);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
          )
        ],
      ),
    );
  }
}
