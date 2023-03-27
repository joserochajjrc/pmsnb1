import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/models/event__model.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';

class ModalAddEvent extends StatefulWidget {
  ModalAddEvent({super.key, this.eventModel, this.fecha});

  EventModel? eventModel;
  String? fecha;

  @override
  State<ModalAddEvent> createState() => _ModalAddEventState();
}

class _ModalAddEventState extends State<ModalAddEvent> {

  database_helper? database;
  TextEditingController txtDescEvent = TextEditingController();
  bool _completado=false;
  

  @override
  void initState() {
    super.initState();
    database = database_helper();
    txtDescEvent.text = widget.eventModel != null ? widget.eventModel!.dscEvent! : '';
  }

  @override
  Widget build(BuildContext context) {
    
    FlagsProvider flags = Provider.of<FlagsProvider>(context);
    

    return AlertDialog(
      title: Text('Crear Evento'),
      content: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: txtDescEvent,
              maxLines: 5,
            ),
            Checkbox(
              value: _completado, 
              onChanged: (isChecked){
                setState(() {
                  _completado = isChecked!;
                });
              }
              
            ), 
            IconButton(
              onPressed: (){

                if(widget.eventModel == null){
                  database!.INSERTAR('tblEvents', {
                    'dscEvent' : txtDescEvent.text,
                    //'dateEvent' : fecha,
                    'complete': _completado
                  }).then((value){
                  
                    var msg = value > 0 ? 'Evento Agregado.' : 'Ocurrio un error!';
                    final snackBar = SnackBar(content: Text(msg));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    flags.setupdatePosts();
                  });
                } else {
                  database!.ACTUALIZAR('tblEvents', {
                    'idEvent' : widget.eventModel!.idEvent,
                    'dscEvent' : txtDescEvent.text,
                    //'dateEvent' : fecha,
                    'complete' : _completado
                  }).then((value) {
                    var msg = value > 0 ? 'Evento Actualizado.' : 'Ocurrio un error!';
                    final snackBar = SnackBar(content: Text(msg));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    flags.setupdatePosts();
                  });
                }
              }, 
              icon: Icon(Icons.add),
              iconSize: 40,
            )
          ],
        ),
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}