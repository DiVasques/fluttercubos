import 'package:flutter/material.dart';
import 'package:flutter_cubos/utils/app_colors.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final List<String> genres;
  MovieCard(
      {@required this.posterUrl, @required this.title, @required this.genres});
  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        MediaQuery.of(context).size.width - 40; // 40 comes from padding
    final double cardHeight = screenWidth * 1.5;
    return Container(
      height: cardHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            spreadRadius: -20,
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              FadeInImage.memoryNetwork(
                image: posterUrl,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 50,
                        color: Colors.black.withOpacity(.9),
                        blurRadius: 30,
                        offset: Offset(0.0, cardHeight / 1.25)
                        // blurRadius: 1,
                        // spreadRadius: 200,
                        )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        genres.length > 1
                            ? '${genres[0]} - ${genres[1]}'
                            : genres[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
