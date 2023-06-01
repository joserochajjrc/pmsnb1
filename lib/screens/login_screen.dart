import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/firebase/email_auth.dart';
import 'package:pmsnb1/responsive.dart';
import 'package:pmsnb1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

EmailAuth emailAuth = EmailAuth();
TextEditingController conEmail = TextEditingController();
TextEditingController conPass = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;
  late StreamSubscription _subs;
  bool loader = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      emailAuth.signInWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
    }
  }

  void onClickGitHubLoginButton() async {
    const String url =
        "https://github.com/login/oauth/authorize?client_id=15b6215cdb2ddf501d02&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  @override
  Widget build(BuildContext context) {

    final txtEmail = TextFormField(
      decoration: const InputDecoration(
        label: Text('Email User'),
        enabledBorder: OutlineInputBorder()),
         validator: (value) {
          if (value != null && !EmailValidator.validate(value)) {
            return 'Ingresa un correo valido';
          } else {
            return null;
          }
        }
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
      onPressed: () {
        Navigator.pushNamed(context, '/dash');
      },
      /*onPressed: () async {
          if (formKey.currentState!.validate()) {
            final emaiT = conEmail.text;
            final passT = conPass.text;
            if ("".compareTo(conEmail.text) == 0 ||
                "".compareTo(conPass.text) == 0) {
            } else {
              try {
                //FacebookAuth.instance.logOut();
                FirebaseAuth.instance.signOut();
                var ban = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: emaiT, password: passT);
                if (ban.user?.emailVerified ?? false) {
                  Navigator.pushNamed(context, '/dash');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: Verifica tu correo'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: Datos no validos'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        }*/
    );

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google, 
      onPressed: () async {
          await emailAuth.signInWithGoogle(context);
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });
        }
    );

    final btnGit = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook, 
      onPressed: () async {
          try {
            var result = await emailAuth.signInWithFacebook();

            if (result.user != null) {
              Navigator.pushNamed(context, '/dashboard');
            } else {
              final snackbar = SnackBar(
                content: const Text('Revisa los datos ingresados'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          } catch (e) {}
        }
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

    final txtAbout = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        onPressed: (){
          Navigator.pushNamed(context, '/onboarding');
        },
        child: const Text('Acerca de...',
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
                  btnAbout: txtAbout,
                  txtEmail: txtEmail,
                  txtPass: txtPass,
                  btnLogin: btnLogin,
                  btnGoogle: btnGoogle,
                  btnGit: btnGit),
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
                                btnRegister: txtRegister,
                                btnAbout: txtAbout))
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
                              btnGit: btnGit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              tablet: Row(
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
                                btnRegister: txtRegister,
                                btnAbout: txtAbout))
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
                              btnGit: btnGit),
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
    required this.btnGit,
    required this.btnRegister,
    required this.btnAbout,
  });

  final SizedBox spaceHorizontal;
  final Padding btnRegister;
  final Padding btnAbout;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnGit;

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
                spaceHorizontal: spaceHorizontal, btnRegister: btnRegister, btnAbout: btnAbout),
            LoginForm(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnGit: btnGit),
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
    required this.btnGit,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnGit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtEmail,
        spaceHorizontal,
        txtPass,
        spaceHorizontal,
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
        btnGit,
      ],
    );
  }
}

class LoginScreenTopWidget extends StatelessWidget {
  const LoginScreenTopWidget({
    super.key,
    required this.spaceHorizontal,
    required this.btnRegister,
    required this.btnAbout,
  });

  final SizedBox spaceHorizontal;
  final Padding btnRegister;
  final Padding btnAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHorizontal,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnRegister,
            btnAbout,
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
