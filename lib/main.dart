import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wensa/splashscreen.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorite Places & Restaurants',
      theme: lightmode,  // Define your light mode theme
      darkTheme: darkmode,  // Define your dark mode theme
      themeMode: ThemeMode.system,  // Let the system decide, or force light/dark mode
      home: SplashScreen()
    );
  }
}


// Define your custom colors for both light and dark themes
const Color alert = Color(0xFFFF2929);
const Color headline = Color(0xFFFF6F3C);
const Color headline2 = Color(0xFFFFD93D);
const Color secondary = Color(0xFF4FC3F7);
const Color secondary2 = Color(0xFF81C784);
const Color balance = Color(0xFFFF9EAA);
const Color balance2 = Color(0xFF957DAD);
const Color background = Color(0xFFFFF7E3);
const Color background2 = Color(0xFFF5F5F5);
const Color button = Color(0xFF06768D);
const Color circle = Color(0xFFE9E9E9);
const Color black = Color(0xFF000000);
const Color shadegrey = Color(0xFFE9E9E9);
const Color shadegrey2 = Color(0xFF303030);
const Color fieldhover = Color(0xFFf0f5f7);
const Color blackground = Color(0xFF181818);

// AppTextStyles for consistent styling across both light and dark themes
class AppTextStyles {
  static TextStyle pageTextStyle(Color color,double size) {
    return GoogleFonts.acme(
      textStyle: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static TextStyle satosh(Color color) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontSize: 15,
      color: color,
    );
  }

  static TextStyle satoshbig(Color color, double size) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontSize: size,
      color: color,
    );
  }

  static TextStyle detailsTextStyle(Color color) {
    return GoogleFonts.notoSans(
      textStyle: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}