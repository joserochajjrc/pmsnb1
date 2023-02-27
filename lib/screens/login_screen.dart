import 'package:flutter/material.dart';
import 'package:pmsnb1/responsive.dart';
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
                    image: AssetImage("assets/fondoitcelaya.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: responsive(
              mobile: MobileLoginScreen(
                  spaceHorizontal: spaceHorizontal,
                  btnRegister: txtRegister,
                  txtEmail: txtEmail,
                  txtPass: txtPass,
                  btnLogin: btnLogin,
                  btnGoogle: btnGoogle,
                  btnFacebook: btnFacebook),
              desktop: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 450,
                          child: Center(child: TopLoginImage()),
                        ),
                        SizedBox(
                            child: LoginScreenTopWidget(
                                spaceHorizontal: spaceHorizontal,
                                btnRegister: txtRegister))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: LoginForm(
                              txtEmail: txtEmail,
                              spaceHorizontal: spaceHorizontal,
                              txtPass: txtPass,
                              btnLogin: btnLogin,
                              btnGoogle: btnGoogle,
                              btnFacebook: btnFacebook),
                        ),
                      ],
                    ),
                  ),
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

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btnRegister,
  });

  final SizedBox spaceHorizontal;
  final Padding btnRegister;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100, child: TopLoginImage()),
            LoginScreenTopWidget(
                spaceHorizontal: spaceHorizontal, btnRegister: btnRegister),
            LoginForm(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnFacebook: btnFacebook),
          ]),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtEmail,
        spaceHorizontal,
        txtPass,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          
        ),
        btnLogin,
        spaceHorizontal,
        const Text(
          "or",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        spaceHorizontal,
        btnGoogle,
        spaceHorizontal,
        btnFacebook,
      ],
    );
  }
}

class LoginScreenTopWidget extends StatelessWidget {
  const LoginScreenTopWidget({
    super.key,
    required this.spaceHorizontal,
    required this.btnRegister,
  });

  final SizedBox spaceHorizontal;
  final Padding btnRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHorizontal,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnRegister,
          ],
        ),
      ],
    );
  }
}

class TopLoginImage extends StatelessWidget {
  const TopLoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logoitc.png',
      height: 250,
    );
  }
}
