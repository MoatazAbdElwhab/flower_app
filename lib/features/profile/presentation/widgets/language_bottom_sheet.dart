import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/profile/presentation/widgets/custom_lang_radio.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late Locale selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLocale = context.locale;
  }

  void _onLanguageSelected(Locale locale) {
    EasyLocalization.of(context)!.setLocale(locale);
    setState(() => selectedLocale = locale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.profile_changeLanguage.tr(),
              style: getBoldStyle(
                fontSize: 20.sp,
                color: AppColors.primary,
              )),
          const SizedBox(height: 16),
          CustomLangRadio(
            title: 'العربية',
            localeValue: const Locale('ar', 'AE'),
            selectedLocale: selectedLocale,
            onSelected: _onLanguageSelected,
          ),
          CustomLangRadio(
            title: 'English',
            localeValue: const Locale('en', 'US'),
            selectedLocale: selectedLocale,
            onSelected: _onLanguageSelected,
          ),
        ],
      ),
    );
  }
}
