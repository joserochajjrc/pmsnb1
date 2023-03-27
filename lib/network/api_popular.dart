import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsnb1/models/popular_model.dart';

class ApiPopular {

  final URL = "https://api.themoviedb.org/3/movie/popular?api_key=4cdb6e42e276c71ca9dbe088cc455570&language=es-MX&page=1";

  Future<List<PopularModel>?> getAllPopular() async{
    final response = await http.get(Uri.parse(URL));
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular = popular.map((video) => PopularModel.fromMap(video)).toList();
      return listPopular;
    }
    return null;
  }
}