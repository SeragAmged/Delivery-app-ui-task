import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.foodCategory});
  final FoodCategory foodCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
            height: 64.h,
            width: 64.h,
            decoration: BoxDecoration(
              color: Color(foodCategory.color).withAlpha(90),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              foodCategory.image,
              fit: BoxFit.contain,
              height: 32.h,
              width: 32.h,
            ),
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          foodCategory.name,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular12.copyWith(color: AppColors.darkblue73),
        )
      ],
    );
  }
}
