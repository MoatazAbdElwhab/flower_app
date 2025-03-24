// features/auth/presentation/widget/remember_me.dart
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = context.read<AuthCubit>().rememberMe;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                value = newValue;
                context.read<AuthCubit>().setRememberMe(newValue);
              });
            }
          },
        ),
        Text(
          'Remember me',
          style: getRegularStyle(color: AppColors.black),
        ),
      ],
    );
  }
}
