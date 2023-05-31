import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsnb1/models/actor_model.dart';
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

  Future<String> getVideo(int id) async {
    final URL =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=4cdb6e42e276c71ca9dbe088cc455570';
    final response = await http.get(Uri.parse(URL));
    var listVideo = jsonDecode(response.body)['results'] as List;
    if (response.statusCode == 200) {
      listVideo = jsonDecode(response.body)['results'] as List;
    }
    for (var element in listVideo) {
      if (element['type'] == 'Trailer') {
        return element['key'];
      }
    }
    return '';
  }

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async {
    final URL =
        'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=4cdb6e42e276c71ca9dbe088cc455570';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var listActor = jsonDecode(response.body)['cast'] as List;
      return listActor.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
  
}