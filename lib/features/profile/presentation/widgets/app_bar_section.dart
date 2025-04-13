import 'package:flower_app/core/resources/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Image.asset(
          AppIcon.logo,
          width: 90,
          height: 25,
          fit: BoxFit.fill,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppIcon.notification,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}
