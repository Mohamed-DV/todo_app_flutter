import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_flutter/utils/Bottom_bar.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

 void _navigateToHome() async {
  await Future.delayed(Duration(seconds: 2));
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgtodo.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Tdo',
                  style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Life is\ngetting mess',
                      
                         style: GoogleFonts.balooChettan2(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
                    ),
                     SizedBox(height: 24),
                    Text(
                      'Organize tasks, set deadlines, and stay productive. Prioritize, get reminders, and check off completed items—all in one simple tool.',
                                 style: GoogleFonts.balooChettan2(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
       
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  }