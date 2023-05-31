import 'package:flutter/material.dart';
import 'package:pmsnb1/database/database_helper.dart';
import 'package:pmsnb1/models/event__model.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';

class ModalAddEvent extends StatefulWidget {
  ModalAddEvent({super.key, this.eventModel, this.fecha});

  final EventModel? eventModel;
  final String? fecha;

  @override
  State<ModalAddEvent> createState() => _ModalAddEventState();
}

class _ModalAddEventState extends State<ModalAddEvent> {

  database_helper? database;
  TextEditingController txtDescEvent = TextEditingController();
  bool completado=false;
  DateTime selectedDate = DateTime.now();
  String selectedDateFormat = "";
  

  @override
  void initState() {
    super.initState();
    database = database_helper();
    txtDescEvent.text = widget.eventModel != null ? widget.eventModel!.dscEvent! : '';

    /*if (widget.eventModel != null) {
      selectedDateFormat = widget.eventModel!.dateEvent!;
      selectedDate = DateTime.parse(widget.eventModel!.dateEvent!);
    } else {
      if (widget.fecha != null) {
        selectedDate = widget.fecha!;
        //selectedDateFormat = DateFormat('yyyy-MM-dd').format(widget.fecha!);
      } else {
        selectedDate = DateTime.now();
        //selectedDateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    }*/

    if (widget.eventModel != null) {
      if (widget.eventModel!.complete == 1) {
        completado = true;
      } else {
        completado = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    FlagsProvider flags = Provider.of<FlagsProvider>(context);
    

    return AlertDialog(
      title: widget.eventModel == null 
      ? Text('Crear Evento')
      : Text('Editar Evento'),
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
              value: completado, 
              onChanged: (isChecked){
                setState(() {
                  completado = isChecked!;
                });
              }
              
            ), 
            IconButton(
              onPressed: (){
                print(txtDescEvent.text);
                print(widget.fecha);
                print(completado);

                if(widget.eventModel == null){
                  database!.INSERTAR('tblEvents', {
                    'dscEvent' : txtDescEvent.text,
                    'dateEvent' : widget.fecha,
                    'complete': widget.eventModel!.complete
                  }).then((value){
                    var msg = value > 0 ? 'Evento Agregado.' : 'Ocurrio un error!';
                    final snackBar = SnackBar(content: Text(msg));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    flags.setupdatePosts();
                  });
                } else {
                  database!.ACTUALIZARevent('tblEvents', {
                    'idEvent' : widget.eventModel!.idEvent,
                    'dscEvent' : txtDescEvent.text,
                    'dateEvent' : widget.fecha,
                    'complete' : widget.eventModel!.complete
                  },'idEvent').then((value) {
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