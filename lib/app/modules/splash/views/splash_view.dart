import 'package:callidus_store/app/core/values/app_colors.dart';
import 'package:callidus_store/app/core/values/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with circular border
            Container(
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo/callidus_play-logo.png',
                  width: 134,
                  height: 134,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            // App Name
            const Text(
              'CallidusPlay',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.fontXxl,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimensions.sm),
            // Tagline
            Text(
              'Your Ultimate Sports Store',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: Dimensions.fontMd,
              ),
            ),
            const SizedBox(height: Dimensions.xl),
            // Loading indicator with custom color
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
