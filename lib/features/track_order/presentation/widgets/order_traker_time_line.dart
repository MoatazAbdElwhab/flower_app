import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class OrderTrackerTimeline extends StatelessWidget {
  final int currentStep;

  const OrderTrackerTimeline({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'title': 'Received your order',
        'time': '03 Sep 2024 - 2:10',
        'isActive': currentStep >= 0,
      },
      {
        'title': 'Preparing your order',
        'time': '03 Sep 2024 - 2:10',
        'isActive': currentStep >= 1,
      },
      {
        'title': 'Out for delivery',
        'time': '03 Sep 2024 - 2:10',
        'isActive': currentStep >= 2,
      },
      {
        'title': 'Delivered',
        'time': '03 Sep 2024 - 2:10',
        'isActive': currentStep >= 3,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final bool isActive = step['isActive'] as bool;
        final bool isLast = index == steps.length - 1;
        final bool isCurrentStep = currentStep == index;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 0.0,
                        end: isActive ? 1.0 : 0.0,
                      ),
                      builder: (context, value, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 24 * value,
                              height: 24 * value,
                              decoration: BoxDecoration(
                                color: isCurrentStep 
                                    ? AppColors.primary 
                                    : isActive 
                                        ? AppColors.primary.withOpacity(0.8) 
                                        : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: isActive && value > 0.7
                                  ? Icon(
                                      Icons.check,
                                      size: 16 * value,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isActive 
                                      ? AppColors.primary 
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    if (!isLast)
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0.0,
                          end: isActive ? 1.0 : 0.0,
                        ),
                        builder: (context, value, child) {
                          return Stack(
                            children: [
                              Container(
                                width: 2,
                                height: 50,
                                color: Colors.grey[300],
                              ),
                              Container(
                                width: 2.w,
                                height: 50 * value,
                                color: AppColors.primary,
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.only(
                      top: 3,
                      left: isActive ? 0 : 8.0,
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isActive ? 1.0 : 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 500),
                            style: TextStyle(
                              fontSize: isActive ? 16 : 15,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              color: isActive ? Colors.black : Colors.grey[600],
                            ),
                            child: Text(step['title'] as String),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            step['time'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!isLast) const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}