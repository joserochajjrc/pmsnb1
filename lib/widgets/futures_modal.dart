  import 'package:flutter/material.dart';
import 'package:pmsnb1/models/event__model.dart';
import 'package:pmsnb1/models/post_model.dart';
import 'package:pmsnb1/widgets/modal_add_event.dart';
import 'package:pmsnb1/widgets/modal_add_post.dart';

openCustomDialog(BuildContext context, PostModel? postModel){
  return showGeneralDialog(
    context: context, 
    barrierColor: Colors.black.withOpacity(.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: ModalAddPost(postModel: postModel),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: ((context, animation, secondaryAnimation) {
      return Container();
    })
  );
}

openEventsDialog(BuildContext context, EventModel? eventModel, String fecha){
  return showGeneralDialog(
    context: context, 
    barrierColor: Colors.black.withOpacity(.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: ModalAddEvent(eventModel: eventModel, fecha: fecha),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: ((context, animation, secondaryAnimation) {
      return Container();
    })
  );
}