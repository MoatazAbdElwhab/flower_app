// features/splash/splash_screen.dart
import 'dart:async';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();

    _timer = Timer(const Duration(milliseconds: 2500), () {
      context.read<AuthCubit>().checkSavedToken();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.signInState is BaseSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state.signInState is BaseErrorState) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else if (state.signInState is BaseInitialState &&
            !_animationController.isAnimating) {
          Navigator.pushReplacementNamed(context, Routes.login);
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
}
