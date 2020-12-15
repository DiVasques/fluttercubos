import 'package:flutter/material.dart';
import 'package:flutter_cubos/controllers/home.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
      final TextEditingController searchFormFieldController = TextEditingController();
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
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Filmes",
                                style: TextStyle(
                                    color: Colors.grey[850],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                            TextFormField(controller: searchFormFieldController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: searchFormFieldController.text.isNotEmpty
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
                                      Radius.circular(50),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor, width: 2),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Pesquise filmes",
                                  fillColor: Colors.grey[200]),
                            )
                          ],
                        ),
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
}
