import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  File? _image;

  Future getImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if( image == null ) return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    
  }

  @override
  Widget build(BuildContext context) {

    final txtName = TextFormField(
      decoration: const InputDecoration(
        label: Text('Name User'),
        enabledBorder: OutlineInputBorder()
      ),
    );

    final txtEmail = TextFormField(
      decoration: const InputDecoration(
        label: Text('Email User'),
        enabledBorder: OutlineInputBorder()
      ),
    );

    final txtPass = TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        label: Text('Password User'),
        enabledBorder: OutlineInputBorder()
      ),
    );

    final spaceHorizontal = SizedBox(height: 15,);
    final spaceGiant = SizedBox(height: 150,);

    final btnRregister = ElevatedButton(
      onPressed: (){
        
      }, 
      
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        fixedSize: const Size(800, 60)
      ),
      
      child: const Text('Registrarse'),
    );

    final btnGallery = ElevatedButton(
      onPressed: (){
        getImage(ImageSource.gallery);
      }, 

      style: ElevatedButton.styleFrom(
        fixedSize: const Size(200, 50)
      ),

      child: Row(
        children: [
          Icon(Icons.image_outlined),
          SizedBox(
            width: 20,
          ),
          Text('Pick from Gallery')
        ],
      )
    );

    final btnCamera = ElevatedButton(
      onPressed: (){
        getImage(ImageSource.camera);
      }, 

      style: ElevatedButton.styleFrom(
        fixedSize: const Size(200, 50)
      ),

      child: Row(
        children: [
          Icon(Icons.camera),
          SizedBox(
            width: 20,
          ),
          Text('Pick from Camera')
        ],
      )
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondoregistro.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9
          )
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  spaceHorizontal,
                  spaceHorizontal,
                  spaceHorizontal,
                  _image != null ? Image.file(_image!, width: 150, height: 150, fit: BoxFit.cover, ) : Image.asset('assets/avatar.png', width: 150,),
                  spaceHorizontal,
                  spaceHorizontal,
                  btnGallery,
                  spaceHorizontal,
                  btnCamera,
                  spaceHorizontal,
                  txtName,
                  spaceHorizontal,
                  txtEmail,
                  spaceHorizontal,
                  txtPass,
                  spaceHorizontal,
                  spaceHorizontal,
                  spaceHorizontal,
                  btnRregister,
                  spaceGiant
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

