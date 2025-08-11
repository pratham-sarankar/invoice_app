import 'package:flutter/material.dart';
import '../utils/auth_utils.dart';

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);

  @override
  void initState() {
    super.initState();
    // Use a safe navigation approach
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          _checkAuthStatus();
        }
      });
    });
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await AuthUtils.isLoggedIn();
      if (mounted) {
        if (isLoggedIn) {
          // User is already logged in, navigate to main screen
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          // User is not logged in, navigate to login screen
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    } catch (e) {
      // If there's an error, default to login screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Act T Connect GST Invoice',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Manage your business efficiently',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
