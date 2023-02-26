import 'package:flutter/material.dart';
import 'package:pmsnb1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

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

    final btnLogin = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin, 
      onPressed: (){
        isLoading = true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 3000)).then((value){
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      }
    );

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google, 
      onPressed: (){}
    );

    final btnFacebook = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook, 
      onPressed: (){}
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        onPressed: (){
          Navigator.pushNamed(context, '/register');
        }, 
        child: const Text('Crear cuenta :)', 
          style: TextStyle(decoration: TextDecoration.underline)
        )
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondoitcelaya.jpg'), 
                fit: BoxFit.cover, 
                opacity: 0.4
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
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnLogin,
                      spaceHorizontal,
                      const Text('or'),
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      txtRegister
                    ],),
                    Positioned(
                      top: 70,
                      child: Image.asset('assets/logoitc.png', 
                      height: 250,
                    ),
                        
                    )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    ); 
  }
}