import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/checkout_cubit.dart';

class GiftSection extends StatelessWidget {
  const GiftSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return ValueListenableBuilder(
      valueListenable: cubit.isGift,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.toggleGift();
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      height: 30,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Switch.adaptive(
                          value: cubit.isGift.value,
                          onChanged: (value) {
                            cubit.toggleGift();
                          },
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      LocaleKeys.checkout_it_is_a_gift.tr(),
                      style: getMediumStyle(
                        color: AppColors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: cubit.isGift.value
                    ? Column(
                        children: [
                          const SizedBox(height: 16),
                          TextField(
                            controller: cubit.nameController,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.checkout_enter_the_name.tr(),
                              labelText: LocaleKeys.checkout_name.tr(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            controller: cubit.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: LocaleKeys
                                  .checkout_enter_the_phone_number
                                  .tr(),
                              labelText: LocaleKeys.checkout_phone_number.tr(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}
