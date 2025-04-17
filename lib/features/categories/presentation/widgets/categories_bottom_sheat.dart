import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
        color: AppColors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: const Color(0xff434343),
                    ),
                  ),
                )),
            Text(
              "Sort by",
              style:
                  getExtraBoldStyle(color: AppColors.primary, fontSize: 20.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16.h,
                  );
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff00000),
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lowes Price",
                          style: getRegularStyle(
                              color: AppColors.black, fontSize: 16.sp),
                        ),
                        Radio(
                          value: "Lowes Price",
                          groupValue: "Lowes Price",
                          onChanged: (value) {},
                          activeColor: AppColors.primary,
                          hoverColor: AppColors.primary,
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              "price",
              style: getMediumStyle(color: AppColors.primary, fontSize: 16.sp),
            ),
            SliderTheme(
              data: SliderThemeData(
                trackShape: RectangularSliderTrackShape(),
                valueIndicatorTextStyle:
                    getMediumStyle(color: AppColors.black, fontSize: 16.sp),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                thumbColor: AppColors.primary,
              ),
              child: RangeSlider(
                values: const RangeValues(0, 250),
                max: 250,
                min: 0,
                activeColor: AppColors.primary,
                labels: RangeLabels("0", "250"),
                overlayColor: WidgetStatePropertyAll(AppColors.primary),
                onChanged: (value) {},
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Filter",
                    style: getRegularStyle(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
