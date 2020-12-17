import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubos/controllers/base_controller.dart';
import 'package:flutter_cubos/controllers/movie_details.dart';
import 'package:flutter_cubos/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;
  MovieDetailsView(this.movieId);
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
    return ChangeNotifierProvider<MovieDetailsProvider>(
      create: (_) => MovieDetailsProvider(movieId: movieId),
      child: Consumer<MovieDetailsProvider>(
          builder: (context, movieDetailsProvider, _) {
        return movieDetailsProvider.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.textBlack),
                  backgroundColor: AppColors.lightGrey,
                ),
              )
            : movieDetailsProvider.state == ViewState.Error
                ? Center(
                    child: Text(
                      movieDetailsProvider.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                  )
                : SingleChildScrollView(
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
                                          padding: EdgeInsets.only(
                                              top: posterHeight / 2 + 30,
                                              bottom: 30),
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
                                                  text: movieDetailsProvider
                                                      .movie.voteAverage
                                                      .toString(),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.accentColor,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " / 10",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.hintTextColor,
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
                                            movieDetailsProvider.movie.title
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ), //title
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15, bottom: 20),
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
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                TextSpan(
                                                  text: movieDetailsProvider
                                                      .movie.originalTitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            greyBlock(
                                                text1: "Ano",
                                                text2: movieDetailsProvider
                                                    .movie.releaseYear),
                                            greyBlock(
                                                text1: "Duração",
                                                text2: movieDetailsProvider
                                                    .movie.runtime),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 5,
                                          alignment: WrapAlignment.center,
                                          children: movieDetailsProvider
                                              .movie.genres
                                              .map((genre) =>
                                                  genderBlock(gender: genre))
                                              .toList(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 60, bottom: 10),
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
                                            movieDetailsProvider.movie.overview,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        expandedGreyBlock(
                                          text1: "Orçamento",
                                          text2: movieDetailsProvider
                                                      .movie.budget ==
                                                  0
                                              ? "Informação indisponível"
                                              : NumberFormat.currency(
                                                      decimalDigits: 0,
                                                      symbol: '\$ ')
                                                  .format(movieDetailsProvider
                                                      .movie.budget),
                                        ),
                                        expandedGreyBlock(
                                          text1: "Produtoras",
                                          text2: movieDetailsProvider
                                              .movie.company,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 40, bottom: 10),
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
                                            movieDetailsProvider.movie.crew
                                                .toString()
                                                .replaceAll(r'[', '')
                                                .replaceAll(r']', ''),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 40, bottom: 10),
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
                                            movieDetailsProvider.movie.cast
                                                .toString()
                                                .replaceAll(r'[', '')
                                                .replaceAll(r']', ''),
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
                              posterUrl: movieDetailsProvider.movie.posterUrl,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
      }),
    );
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
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
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
                style: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
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
        child: FadeInImage(
          image: CachedNetworkImageProvider(
            posterUrl,
          ),
          fit: BoxFit.cover,
          placeholder: MemoryImage(kTransparentImage),
        ),
      ),
    );
  }
}
