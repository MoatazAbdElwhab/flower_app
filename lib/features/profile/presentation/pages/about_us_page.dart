// features/profile/presentation/pages/about_us_page.dart
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.profile_aboutUs.tr(),
              style: getMediumStyle(color: AppColors.black, fontSize: 18.sp)),
          backgroundColor: AppColors.scaffoldBackground,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        body: const AboutUsContent(),
      );
}

class AboutUsContent extends StatefulWidget {
  const AboutUsContent({super.key});
  @override
  State<AboutUsContent> createState() => _AboutUsContentState();
}

class _AboutUsContentState extends State<AboutUsContent> {
  Map<String, dynamic>? _data;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/about_us.json')
        .then((data) => setState(() {
              _data = json.decode(data);
              _isLoading = false;
            }))
        .catchError((e) => setState(() {
              _error = 'Failed to load data: $e';
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (_error.isNotEmpty) {
      return Center(
          child: Text(_error,
              style: getRegularStyle(color: AppColors.error, fontSize: 16.sp)));
    }
    if (_data == null) {
      return Center(
          child: Text('No data available',
              style: getRegularStyle(color: AppColors.error, fontSize: 16.sp)));
    }

    final lang = context.locale.languageCode == 'ar' ? 'ar' : 'en';
    final rtl = context.locale.languageCode == 'ar';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (_data?['about_app'] ?? []).map<Widget>((section) {
          final type = section['section'] ?? '';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(section, type, lang, rtl),
              if (type != 'closing') _divider(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSection(
      Map<String, dynamic> section, String type, String lang, bool rtl) {
    if (['title', 'introduction', 'closing'].contains(type)) {
      final text = section['content'][lang] ?? '';
      final align = type == 'title'
          ? TextAlign.center
          : rtl
              ? TextAlign.right
              : TextAlign.left;

      if (type == 'closing') {
        return Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: Icon(Icons.local_florist_outlined,
                  size: 30.sp, color: AppColors.primary),
            ),
            SizedBox(height: 16.h),
            Text(text,
                style:
                    getMediumStyle(color: AppColors.primary, fontSize: 16.sp),
                textAlign: align),
            SizedBox(height: 16.h),
          ],
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          text,
          style: type == 'title'
              ? getBoldStyle(color: AppColors.primary, fontSize: 22.sp)
              : getRegularStyle(
                  color: AppColors.grey, fontSize: 16.sp, height: 1.5),
          textAlign: align,
        ),
      );
    }

    if (['our_story', 'features', 'our_commitment', 'contact_us']
        .contains(type)) {
      final title = section['title']?[lang] ?? '';
      final content = section['content']?[lang];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
            child: Text(
              title,
              style: getBoldStyle(color: AppColors.primary, fontSize: 18.sp),
              textAlign: rtl ? TextAlign.right : TextAlign.left,
            ),
          ),
          if (content is List) ...content.map((item) => _bulletItem(item, rtl)),
          if (content is String)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                content,
                style: getRegularStyle(
                    color: AppColors.grey, fontSize: 14.sp, height: 1.5),
                textAlign: rtl ? TextAlign.right : TextAlign.left,
              ),
            ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _bulletItem(String text, bool rtl) => Padding(
        padding: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),
        child: Stack(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: rtl ? 0 : 20.w, right: rtl ? 20.w : 0),
              width: double.infinity,
              child: Text(
                text,
                style: getRegularStyle(
                    color: AppColors.grey, fontSize: 14.sp, height: 1.4),
                textAlign: rtl ? TextAlign.right : TextAlign.left,
              ),
            ),
            Positioned(
              right: rtl ? 0 : null,
              left: rtl ? null : 0,
              top: 7.h,
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      );

  Widget _divider() => Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        height: 1.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppColors.primary.withOpacity(0.3),
              Colors.transparent
            ],
          ),
        ),
      );
}
