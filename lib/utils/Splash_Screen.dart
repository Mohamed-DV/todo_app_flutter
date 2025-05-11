import 'package:flutter/material.dart';
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
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Life is\ngetting mess',
                      style: TextStyle(
                        fontSize: 41,
                        color: Colors.white,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Organize tasks, set deadlines, and stay productive. Prioritize, get reminders, and check off completed items—all in one simple tool.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
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