import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutterlearniti/welcomePages/appscreans/introscrean.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _startAnimation();
  }

  _startAnimation() async {
    await _animationController.forward();
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/introscrean', (Route<dynamic> route) => false,);
      
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.230),
                    SvgPicture.asset(
                      "assets/image/splash_images/logo.svg",
                      width: width * 0.34,
                      height: height * 0.34,
                    ),
                    SizedBox(height: 10),
                    Text("Paperback.", style: theme.textTheme.displayLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
