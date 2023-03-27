import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/models/event__model.dart';
import 'package:pmsnb1/models/post_model.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/widgets/item_event_widget.dart';
import 'package:pmsnb1/widgets/item_post_widget.dart';
import 'package:provider/provider.dart';

class ListEventScreen extends StatefulWidget {
  ListEventScreen({super.key, this.eventModel});

  EventModel? eventModel;

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {

  database_helper? helper;

  @override
  void initState() {
    super.initState();
    helper = database_helper();
  }
  
  @override
  Widget build(BuildContext context) {
    var futPost = helper!.GETALLEVENT();

    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return FutureBuilder(
      future: futPost,
      builder: (context, AsyncSnapshot<List<EventModel>> snapshot) {
        if( snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objEventModel = snapshot.data![index];
              return ItemEventWidget(eventModel: objEventModel);
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