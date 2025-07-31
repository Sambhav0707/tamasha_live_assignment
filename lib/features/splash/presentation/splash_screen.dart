import 'package:flutter/material.dart';
import 'package:tamasha_assignment/core/constants/app_colors.dart';
import 'package:tamasha_assignment/features/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => const HomeScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(
        false,
      ), // Light theme for splash
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColor(false),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getPrimaryColor(false).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.public, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 32),

            // App Name
            Text(
              'Countries',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.getOnSurfaceColor(false),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // App Tagline
            Text(
              'Explore the world',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.getOnSurfaceVariantColor(false),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 48),

            // Loading Indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.getPrimaryColor(false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
