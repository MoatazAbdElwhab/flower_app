// features/home/presentation/pages/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flower_app/features/home/presentation/pages/home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: const HomePage(),
    );
  }
}
