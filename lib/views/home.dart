import 'package:flutter/material.dart';
import 'package:flutter_cubos/controllers/base_controller.dart';
import 'package:flutter_cubos/controllers/home.dart';
import 'package:flutter_cubos/repositories/models/movie.dart';
import 'package:flutter_cubos/utils/app_colors.dart';
import 'package:flutter_cubos/utils/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final TextEditingController searchFormFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (homeNavigatorKey.currentState.canPop())
          homeNavigatorKey.currentState.pop();
        else
          Navigator.pop(context);
        return false;
      },
      child: ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
        child: Navigator(
          key: homeNavigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name == 'any route') {
              return MaterialPageRoute(builder: (context) => Container());
            } else {
              return MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Consumer<HomeProvider>(
                            builder: (context, homeProvider, _) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Filmes",
                                  style: TextStyle(
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                              TextFormField(
                                controller: searchFormFieldController,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.search,
                                      color: AppColors.hintTextColor,
                                    ),
                                  ),
                                  suffixIcon: searchFormFieldController
                                          .text.isNotEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            searchFormFieldController.clear();
                                          },
                                          icon: Icon(Icons.clear),
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(500),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      TextStyle(color: AppColors.hintTextColor),
                                  hintText: "Pesquise filmes",
                                  fillColor: AppColors.lightGrey,
                                ),
                              ),
                              SizedBox(height: 20),
                              homeProvider.state == ViewState.Busy
                                  ? Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColors.textBlack),
                                          backgroundColor: AppColors.lightGrey,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [buildMovieCard(context)],
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMovieCard(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, _) {
      return Column(
        children: homeProvider.moviesList
            .map(
              (Movie movie) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  child: MovieCard(
                      posterUrl: movie.posterUrl,
                      title: movie.title,
                      genres: movie.genres),
                ),
              ),
            )
            .toList(),
      );
    });
  }
}
