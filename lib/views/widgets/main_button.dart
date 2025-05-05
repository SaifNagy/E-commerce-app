import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double height;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String? name;
  final bool isLoading;

  MainButton({
    super.key,
    this.height = 60,
    this.onTap,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
    this.name,
    this.isLoading = false,
  }) {
    assert(name != null || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onTap,
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Text(
                  name!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
