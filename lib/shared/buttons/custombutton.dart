import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final String? networkImage;
  final VoidCallback? ontap;
  final Color backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    this.text,
    this.imagePath,
    this.networkImage,
    this.ontap,
    required this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        //width: 0.6.sw,
        height: 0.06.sh,
        padding: AppSizes.paddingAllSm,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color:
                  colorsScheme.brightness == Brightness.dark
                      ? Colors.black54
                      : Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child:
            text != null
                ? Text(
                  text!,
                  style: TextStyle(
                    fontSize: AppSizes.fontMd,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                )
                : null,
      ),
    );
  }
}
