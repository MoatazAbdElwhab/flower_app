import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class GiftSection extends StatefulWidget {
  final bool isGift;
  final Function(bool) onGiftToggle;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const GiftSection({
    super.key,
    required this.isGift,
    required this.onGiftToggle,
    required this.nameController,
    required this.phoneController,
  });

  @override
  State<GiftSection> createState() => _GiftSectionState();
}

class _GiftSectionState extends State<GiftSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              widget.onGiftToggle(!widget.isGift);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 52,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Switch.adaptive(
                      value: widget.isGift,
                      onChanged: widget.onGiftToggle,
                      activeColor: AppColors.white,
                      activeTrackColor: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'It is a gift',
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
            child: widget.isGift
                ? Column(
                    children: [
                      const SizedBox(height: 16),
                      TextField(
                        controller: widget.nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter the name',
                          labelText: 'Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: widget.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Enter the phone number',
                          labelText: 'Phone number',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
