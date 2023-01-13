import 'package:bloc/bloc.dart';
import 'package:cowlar_project/appbloc_observer.dart';
import 'package:cowlar_project/constants.dart';
import 'package:cowlar_project/screens/booking%20screen/booking_screen_one.dart';
import 'package:cowlar_project/screens/dashboard%20screen/dashboard_screen.dart';
import 'package:cowlar_project/screens/move%20detail%20screen/movie_detail_screen.dart';
import 'package:cowlar_project/screens/movie%20video%20screen/movie_video_screen.dart';
import 'package:cowlar_project/screens/searchable%20screen/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cowlar Project',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/searchable': (context) => SearchProvider(),
        '/moviedetail': (context) => MovieDetailScreen(),
        '/movietrailer': (context) => MovieVideoScreen(),
        '/booking': (context) => BookingScreenOne(),
      },
      home: const DashboardScreen(),
    );
  }
}
