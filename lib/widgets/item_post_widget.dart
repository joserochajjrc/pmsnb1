import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/firebase/port_collection.dart';
import 'package:pmsnb1/widgets/futures_modal.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postModel});

  PostCollection? postCollection = PostCollection();

  database_helper _database = database_helper();
  PostModel? postModel;
  FlagsProvider? flags;

  @override
  Widget build(BuildContext context) {

    flags = Provider.of<FlagsProvider>(context);

    
    final iconMore = Icon(Icons.more_horiz, size: 35,);

    final cardDesc = Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      height: 150,
      color: Colors.green,
      child: Text('${postModel!.dscPost}',),
    );

    final rowFooter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fecha: ${postModel!.datePost} ', style: TextStyle(fontSize: 18),),
        const Icon(Icons.thumb_up)
      ],
    );

    final ribbonTop = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      ),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        height: 50,
        width: double.infinity,
        color: Colors.green[200],
        child: PopupMenuButton(
          icon: iconMore,
          itemBuilder: (context){
              return const [
                PopupMenuItem<int>(child: Text('Editar'), value: 0),
                PopupMenuItem<int>(child: Text('Borrar'), value: 1),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  openCustomDialog(context, postModel);
                  break;
                
                case 1:
                  _showDeleteModal(context);
                  break;
              }
            },
          ),
        ), 
      );
    

    final ribbonBottom = ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        height: 50,
        width: double.infinity,
        child: rowFooter,
        color: Colors.green[200],
      )
    );
    
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        //padding: EdgeInsets.all(10),
        height: 250,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              offset: Offset(0, 8)
            ),
          ],
          color: Colors.green,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            ribbonTop,
            cardDesc,
            ribbonBottom
          ],
        ),
      ),
    );
  }

  _showDeleteModal(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: const Text('¿Desea borrar el post?'),
          actions: [
            TextButton(
              onPressed: (){
                postCollection!.deletePost(postModel!.idPost!);
                //_database.ELIMINAR('tblPost', postModel!.idPost!);
                Navigator.pop(context);
                flags!.setupdatePosts();
              }, 
              child: const Text('Aceptar')
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Cancelar')
            )
          ],
        );
      }
    );
  }

}

