import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewView extends StatefulWidget {
  const WriteReviewView({super.key});

  @override
  State<WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  final TextEditingController titleController = TextEditingController();
  final commentController = TextEditingController();
  double userRating = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    sbh(20),
                    _backButton(context),
                    sbh(30),
                    RatingBar.builder(
                      glowColor: const Color.fromARGB(255, 255, 220, 116),
                      initialRating: 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 50,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      unratedColor: mediumGray,
                      onRatingUpdate: (rating) {
                        userRating = rating;
                        print(userRating);
                      },
                    ),
                    sbh(20),
                    Text(
                      'Press the stars to add a rating',
                      style:
                          mediumText.copyWith(color: lightGray, fontSize: 13),
                    ),
                    sbh(20),
                    const Divider(
                      color: darkGray,
                      thickness: 1.2,
                    ),
                    sbh(15),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        autocorrect: true,
                        style: mediumText.copyWith(
                            color: Colors.white, fontSize: 15),
                        controller: titleController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          focusColor: actionColor,
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: MediaQuery.of(context).size.height *
                                    0.92 /
                                    2),
                            child: const Icon(Icons.edit_rounded),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          filled: true,
                          fillColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Title',
                          hintStyle: regularText.copyWith(
                            color: lightGray,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: darkGray,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.53,
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        autocorrect: true,
                        style: mediumText.copyWith(
                            color: Colors.white, fontSize: 15),
                        controller: commentController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          focusColor: actionColor,
                          suffixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.92 /
                                      2),
                              child: const Icon(Icons.edit_rounded)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          filled: true,
                          fillColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Review',
                          hintStyle: regularText.copyWith(
                            color: lightGray,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 11, bottom: 11),
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: Color.fromARGB(255, 172, 172, 172),
                    width: 0.5,
                  )),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor: actionColor,
                        padding: const EdgeInsets.all(0),
                        onTap: () {
                          if (userRating != 0 && commentController.text != '') {
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              showCloseIcon: true,
                              closeIconColor: Colors.white,
                              backgroundColor: Colors.red,
                              content: Text(
                                'Missing fields',
                                style: boldText.copyWith(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ));
                          }
                        },
                        title: Text(
                          'Send',
                          style: boldText.copyWith(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    if (MediaQuery.of(context).viewInsets.bottom != 0) sbw(8),
                    if (MediaQuery.of(context).viewInsets.bottom != 0)
                      SizedBox(
                        width: 55,
                        child: CustomButton(
                          padding: const EdgeInsets.only(bottom: 0),
                          backgroundColor:
                              const Color.fromARGB(255, 142, 142, 142),
                          height: 55,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          title: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Align _backButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: darkGray,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: Icon(
              Icons.close_rounded,
              size: 25,
              color: lightGray,
            ),
          ),
        ),
      ),
    );
  }
}
