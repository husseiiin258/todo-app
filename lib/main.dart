import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'layout/home_layout.dart';
void main(){
runApp( const MyApp()) ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) =>  const SplashScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),

      },
    );
  }
}
