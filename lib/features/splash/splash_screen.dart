import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flower_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../nav/presentation/pages/navbar_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  late Animation<double> _2opacityAnimation;
  late AnimationController _2controller;

  @override
  void initState() {
    super.initState();
    _2controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _2opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _2controller,
        curve: Curves.easeIn,
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _2controller.forward();
    _animationController.forward().then(
      (_) {
        context.read<AuthCubit>().isUserLoggedIn();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.signInState is BaseSuccessState) {
          _animateTo(context, toLogin: false);
        } else if (state.signInState is BaseErrorState) {
          _animateTo(context, toLogin: true);

          Navigator.pushReplacementNamed(context, Routes.login);
        } else if (state.signInState is BaseInitialState) {
          _animateTo(context, toLogin: true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background circles
            Positioned(
              top: -50.h,
              right: -50.w,
              child: Container(
                height: 180.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -60.h,
              left: -30.w,
              child: Container(
                height: 200.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.07),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Splash screen content
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 1000),
                          opacity: _2opacityAnimation.value,
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.15),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              AppIcons.flower,
                              height: 100.h,
                              width: 100.w,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: Text(
                          'Flowery',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: Text(
                          'Beautiful flowers for every occasion',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      // Progress indicator
                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: SizedBox(
                          width: 120.w,
                          child: LinearProgressIndicator(
                            backgroundColor:
                                AppColors.primary.withOpacity(0.15),
                            color: AppColors.primary,
                            minHeight: 4.h,
                            borderRadius: BorderRadius.circular(2.r),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _animateTo(BuildContext context, {required bool toLogin}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Return the appropriate widget based on routeName
          return toLogin ? const LoginPage() : const NavbarPage();
        },
        transitionDuration: const Duration(milliseconds: 1500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Define beautiful slide up + fade transition
          const begin = Offset(0.0, 0.5);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
