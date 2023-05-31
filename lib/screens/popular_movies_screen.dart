import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/network/api_popular.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/screens/detail_movies.dart';
import 'package:pmsnb1/widgets/item_popular_movie.dart';
import 'package:provider/provider.dart';

import '../models/popular_model.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  ApiPopular? apiPopular;
  int favorites = 0;
  database_helper? database;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = database_helper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: flag.getupdatePosts() == true
            ? favorites == 0
                ? database!.GETALLPOPULAR()
                : apiPopular!.getAllPopular()
            : favorites == 1
                ? database!.GETALLPOPULAR()
                : apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  PopularModel model = snapshot.data![index];
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovieDetail(model: model)));
                      },
                      child:
                          ItemPopularMovie(popularModel: snapshot.data![index]),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Algo salio mal :()'),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                itemCount: snapshot.data != null
                    ? snapshot.data!.length
                    : 0, //snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text(
                  'Esta muy vacio por aqui :|',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          return Container();
            /*child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: .8,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  ItemPopularMovie(popularModel: snapshot.data![index]);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                            detailsRecipe(
                            recipeModel: model,
                          )));
                    },
                    child: ItemSpoonacular(
                      recipeModel: snapshot.data![index]),
                );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Algo salio mal :()'),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
              itemCount: snapshot.data != null
                  ? snapshot.data!.length
                  : 0, //snapshot.data!.length,
            ),*/
        },
      ),
    );
  }
}