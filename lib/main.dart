import 'package:flutter/material.dart';
import 'package:flutter_cubos/utils/app_colors.dart';
import 'package:flutter_cubos/utils/routers/main_router.dart';
import 'package:flutter_cubos/utils/widgets/movie_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Cubos',
      onGenerateRoute: MainRouter.generateRoute,
      initialRoute: homeRoute,
      theme: ThemeData(
        accentColor: AppColors.accentColor,
        iconTheme: IconThemeData(color: AppColors.accentColor),
        fontFamily: 'Montserrat',
      ),
    );
  }
}
