// features/profile/presentation/pages/terms_and_conditions.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.profile_termsAndConditions.tr(),
          style: getMediumStyle(
            color: AppColors.black,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: TermsContent(),
      ),
    );
  }
}

class TermsContent extends StatelessWidget {
  const TermsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //------------------------------------------------introduction
          _buildSectionTitle(
              LocaleKeys.profile_terms_introduction.tr(), Icons.info_outline),
          _buildParagraph(
            LocaleKeys.profile_terms_introduction_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------definitions and usage
          _buildSectionTitle(
              LocaleKeys.profile_terms_definitions.tr(), Icons.book_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_definitions_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------account and ordering
          _buildSectionTitle(
              LocaleKeys.profile_terms_account.tr(), Icons.person_outline),
          _buildParagraph(
            LocaleKeys.profile_terms_account_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------delivery
          _buildSectionTitle(LocaleKeys.profile_terms_delivery.tr(),
              Icons.local_shipping_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_delivery_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------cancellation  and refund
          _buildSectionTitle(LocaleKeys.profile_terms_cancellation.tr(),
              Icons.assignment_return_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_cancellation_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------app usage and privacy
          _buildSectionTitle(LocaleKeys.profile_terms_app_usage.tr(),
              Icons.phone_android_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_app_usage_text.tr(),
          ),
          _buildDivider(),
          //------------------------------------------------legal matters
          _buildSectionTitle(
              LocaleKeys.profile_terms_legal.tr(), Icons.gavel_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_legal_text.tr(),
          ),
          _buildDivider(),

          //------------------------------------------------contact us
          _buildSectionTitle(LocaleKeys.profile_terms_contact.tr(),
              Icons.contact_support_outlined),
          _buildParagraph(
            LocaleKeys.profile_terms_contact_text.tr(),
          ),
          _buildContactInfo(context),
          SizedBox(height: 32.h),

          //------------------------------------------------footer
          _buildFooter(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22.sp,
            color: AppColors.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              title,
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: 17.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 32.w),
      child: Text(
        text,
        style: getRegularStyle(
          color: AppColors.grey,
          fontSize: 14.sp,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 1.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primary.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32.w, top: 12.h, bottom: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactRow(
              Icons.email_outlined, LocaleKeys.profile_terms_email.tr()),
          SizedBox(height: 12.h),
          _buildContactRow(
              Icons.phone_outlined, LocaleKeys.profile_terms_phone.tr()),
          SizedBox(height: 12.h),
          _buildContactRow(
            Icons.location_on_outlined,
            LocaleKeys.profile_terms_address.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: AppColors.primary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: getMediumStyle(
              color: AppColors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_florist_outlined,
              size: 24.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            LocaleKeys.profile_terms_thank_you.tr(),
            style: getMediumStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            LocaleKeys.profile_terms_copyright.tr(),
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
