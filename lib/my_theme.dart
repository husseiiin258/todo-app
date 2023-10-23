import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyTheme{
  static Color primaryLight = Color(0xFF5D9CEC);
  static Color primaryDark = Color(0xFF5D9CEC);
  static Color backgroundLight = Color(0xFFDFECDB);
  static Color backgroundDark = Color(0xFF060E1E);
  static Color greenLight = Color(0xFF61E757);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color blackColor = Color(0xFF303030);
  static Color redColor = Color(0xFFEC4B4B);
  static Color grayColor = Color(0xFFC8C9CB);
  static ThemeData lightTheme = ThemeData(
    primaryColor:primaryLight,
    colorScheme: ColorScheme.fromSeed(
       seedColor: Color(0xFF5D9CEC),
      onSecondary: blackColor,
      onPrimary: Color(0xFF5D9CEC),

      onSecondaryContainer: whiteColor,

    ),


    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryLight,
      unselectedItemColor: blackColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      )
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      bodySmall: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFF5D9CEC)),
      titleSmall: GoogleFonts.poppins(
          fontSize: 15, fontWeight: FontWeight.w400, color: blackColor
      )
    ),

  ) ;
  static ThemeData darkTheme = ThemeData(
    primaryColor:Color(0xFF5D9CEC),
    colorScheme: ColorScheme.fromSeed(
      onPrimary: whiteColor,
      seedColor: whiteColor,
      onSecondary: whiteColor,
      onSecondaryContainer: Color(0xff141922),

    ),
    scaffoldBackgroundColor: backgroundDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor:primaryDark ,
      unselectedItemColor: Colors.grey,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
    ),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )
        )
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      bodySmall: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        titleSmall: GoogleFonts.poppins(
            fontSize: 15, fontWeight: FontWeight.w400, color:whiteColor
        )
    ),

  ) ;
}