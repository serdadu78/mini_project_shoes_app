import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project_shoes_app/controllers/auth_controller.dart';
import 'package:mini_project_shoes_app/controllers/bottom_nav_controller.dart';
import 'package:mini_project_shoes_app/controllers/cart_controller.dart';
import 'package:mini_project_shoes_app/controllers/product_controller.dart';

import 'package:mini_project_shoes_app/screens/main_screens.dart';
import 'package:mini_project_shoes_app/screens/cartpage.dart';
import 'package:mini_project_shoes_app/screens/login.dart';
import 'package:mini_project_shoes_app/screens/onboarding.dart';
import 'package:mini_project_shoes_app/screens/register.dart';
import 'package:mini_project_shoes_app/screens/splash_page.dart';

import 'package:mini_project_shoes_app/screens/searchpage.dart';
import 'package:provider/provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => CartController()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500
          ).fontFamily,
        ),

        
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        initialRoute: '/splashpage' ,
        routes: {
          '/mainscreen': (context) => MainScreen(),
          '/homepage': (context) => HomePage(),
          '/searchpage': (context) => SearchPage(),
          '/cartpage': (context) => CartPage(),
          '/splashpage': (context) => SplashPage(),
          '/onboarding': (context) => OnBoardingPage(),
          '/login': (context) => LoginPage(),
          '/splashpage': (context) => SplashPage(),
          '/register': (context) => RegisterPage(),
        },
      ), 
    );
  }
}
