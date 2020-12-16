import 'package:flutter/material.dart';
import 'package:flutter_cubos/controllers/home.dart';
import 'package:flutter_cubos/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Stack(
        children: [
          movieInfo(context),
          backButton(context),
        ],
      ),
    );
  }

  Widget movieInfo(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double posterHorizontalPadding = 77.5;
    final double posterWidth = screenWidth - posterHorizontalPadding * 2;
    final double topPadding = 150;
    final double posterHeight = posterWidth * 1.5;
    final double greyBoxHeight = topPadding + (posterHeight / 2);
    return Consumer<HomeProvider>(builder: (context, homeProvider, _) {
      return SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: greyBoxHeight),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              //TODO: dynamic
                              padding: EdgeInsets.only(
                                  top: posterHeight / 2 + 30, bottom: 30),
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "7.3", //TODO: rating
                                      style: TextStyle(
                                        color: AppColors.accentColor,
                                        fontSize: 25,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " / 10",
                                      style: TextStyle(
                                        color: AppColors.hintTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Capitã Marvel".toUpperCase(), //TODO: title
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ), //title
                            Container(
                              padding: EdgeInsets.only(top: 15, bottom: 20),
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.textBlack,
                                    fontSize: 12,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Título Original: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    TextSpan(
                                      text:
                                          "Captain Marvel", //TODO: original title
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                greyBlock(
                                    text1: "Ano", text2: "2019"), //TODO: year
                                greyBlock(
                                    text1: "Duração",
                                    text2: "1h 20min"), //TODO: duration
                              ],
                            ),
                            Wrap(
                              spacing: 5,
                              alignment: WrapAlignment.center,
                              children: [
                                genderBlock(gender: "Ação"), //TODO: map genders
                                genderBlock(gender: "Aventura"),
                                genderBlock(gender: "Sci-fi"),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 60, bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Descrição",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 40),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //TODO: description
                                "Aventura sobre Carol Danvers, uma agente da CIA que tem contato com uma raça alienígena e ganha poderes sobre-humanos. Entre os seus poderes estão uma força fora do comum e a habilidade de voar.",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            expandedGreyBlock(
                              text1: "Orçamento",
                              text2: "\$ 152,000,000", //TODO: budget
                            ),
                            expandedGreyBlock(
                              text1: "Produtoras",
                              text2: "Marvel studios", //TODO: company
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40, bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Diretor",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //TODO: director
                                "Ryan Fleck, Anna Boden",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40, bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Elenco",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 100),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //TODO: cast
                                "Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: topPadding,
                ),
                posterCard(
                    cardHeight: posterHeight,
                    cardWidth: posterWidth,
                    posterUrl:
                        "https://image.tmdb.org/t/p/original/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg")
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget greyBlock({String text1, String text2}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.lightGrey, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: "$text1: ",
                style: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderBlock({String gender}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          gender.toUpperCase(),
          style: TextStyle(
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget expandedGreyBlock({String text1, String text2}) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2.5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.lightGrey, borderRadius: BorderRadius.circular(5)),
      child: Expanded(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: "$text1: ".toUpperCase(),
                style: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: RaisedButton(
          elevation: 1,
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppColors.hintTextColor,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "Voltar",
                style: TextStyle(color: AppColors.hintTextColor, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget posterCard(
      {String posterUrl, @required cardHeight, @required cardWidth}) {
    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage.memoryNetwork(
          image: posterUrl,
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
        ),
      ),
    );
  }
}
