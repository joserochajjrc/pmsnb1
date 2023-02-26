import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/models/post_model.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {

  database_helper? helper;

  @override
  void initState() {
    super.initState();
    helper = database_helper();
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: helper!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if( snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return widget;
            },
          );
        } else if(snapshot.hasError){
          return Center(child: Text('Ocurrió un error en la petición :)'),);
        } else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}