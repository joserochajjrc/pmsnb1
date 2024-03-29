import 'package:flutter/material.dart';
import 'package:pmsnb1/screens/about_us_screen.dart';
import 'package:pmsnb1/screens/dashboard_screen.dart';
import 'package:pmsnb1/screens/detail_movies.dart';
import 'package:pmsnb1/screens/events_screen.dart';
import 'package:pmsnb1/screens/login_screen.dart';
import 'package:pmsnb1/screens/onboarding_screen.dart';
import 'package:pmsnb1/screens/pokemon_screen.dart';
import 'package:pmsnb1/screens/popular_movies_screen.dart';
import 'package:pmsnb1/screens/register_screen.dart';
import 'package:pmsnb1/screens/user_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/login':(BuildContext context) => LoginScreen(), 
    '/dash':(BuildContext context) => DashboardScreen(),
    '/onboarding':(BuildContext context) => OnboardingScreen(),
    '/popular':(BuildContext context) => PopularMoviesScreen(),
    '/events':(BuildContext context) => eventsScreen(),
    //'/detail':(BuildContext context) => detailMovies(),
    '/aboutUs':(BuildContext context) => AboutUsScreen(),
    '/user':(BuildContext context) => AccountScreen(),
    '/pokemon':(BuildContext context) => PokemonScrenn()
  };
}