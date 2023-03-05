import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/widgets/itcelaya.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final data = [
    itcelaya(
      title: "Nuestra Escuela",
      subtitle: "El Tecnológico de Celaya ahora TecNM en Celaya, inicia actividades el 14 de abril de 1958",
      image: AssetImage('assets/escuela.png'),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      //background_lottie: LottieImage('assets/sea-walk.json'),
      child: Container(),
    ),
    itcelaya(
      title: "Nuestra Carrera",
      subtitle: "Un Ingeniero en Sistemas Computacionales, tiene conocimientos de alto nivel tecnológico.",
      image: AssetImage('assets/sistemas.png'),
      backgroundColor: Colors.white,
      titleColor: Colors.pink,
      subtitleColor: Colors.black,
      //background_lottie: LottieImage('assets/sea-walk.json'),
      child: Container(),
    ),
    itcelaya(
      title: "Instalaciones",
      subtitle: "En sus aulas se ofrecen 11 licenciaturas e ingenierías, 7 maestrías y 4 doctorados.",
      image: AssetImage('assets/instalaciones.jpg'),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      //background_lottie: LottieImage('assets/sea-walk.json'),
      child: retorno(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
      colors: data.map((e) => e.backgroundColor).toList(),
      itemBuilder: (int index) {
          if(data[index]==3){
            return Navigator.pushNamed(context, '/login');
          } else {
            return Itcelaya(data: data[index]);
          }
      },
     ),
    );
  }
}

class LottieImage extends StatelessWidget {
  const LottieImage(this.background, {super.key});

  final String background;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 350),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LottieBuilder.asset(
            background,
            fit: BoxFit.cover,
          ),
        ),
    );
  }
}

class retorno extends StatelessWidget {
    const retorno({super.key});
  
    @override
    Widget build(BuildContext context) {
      return TextButton(
        onPressed: (){
          Navigator.pushNamed(context, '/login');
        }, 
        child: const Text('INICIO', 
          style: TextStyle(decoration: TextDecoration.underline)
        )
      );
    }
  }