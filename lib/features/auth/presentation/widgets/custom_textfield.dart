import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextEditingController? confirmPasswordController;
  final ValueNotifier<bool>? isObscureNotifier; // 🔁 ValueNotifier

  const CustomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.obsecureText = false,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.confirmPasswordController,
    this.isObscureNotifier, // 👈 pass this for obscure toggle
  });

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty!';
    }

    final hint = hintText.toLowerCase();

    if (hint == "email") {
      if (!RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
      ).hasMatch(value)) {
        return 'Enter a valid email!';
      }
    } else if (hint == "password" ||
        hint == "new password" ||
        hint == "confirm password") {
      if (value.length < 8) return 'Password must be at least 8 characters!';
      if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
        return 'Password must contain at least one uppercase letter!';
      }
      if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
        return 'Password must contain at least one number!';
      }
      if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
        return 'Password must contain at least one special character!';
      }
    } else if (hint == "number") {
      if (!RegExp(r"^\d{10,}$").hasMatch(value)) {
        return 'Enter a valid phone number!';
      }
    } else if (hint == "name") {
      if (value.length < 3) return 'Name must be at least 3 characters!';
      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
        return 'Name must contain only letters!';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final notifier = isObscureNotifier ?? ValueNotifier<bool>(obsecureText);

    return SizedBox(
      width: 0.87.sw,
      child: ValueListenableBuilder<bool>(
        valueListenable: notifier,
        builder: (_, isObscure, __) {
          return TextFormField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: AppSizes.fontMd,
              color: colorScheme.onSurface,
            ),
            validator: _validateInput,

            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: AppSizes.fontMd,
                color: colorScheme.onSecondary,
              ),
              contentPadding: EdgeInsets.all(AppSizes.paddingMd),
              prefixIcon:
                  prefixIcon != null
                      ? Icon(prefixIcon, size: AppSizes.iconSm)
                      : null,
              suffixIcon:
                  obsecureText
                      ? GestureDetector(
                        onTap: () => notifier.value = !notifier.value,
                        child: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      )
                      : null,
              filled: true,
              fillColor:
                  colorScheme.brightness == Brightness.dark
                      ? AppTheme.darkBackground
                      : const Color(0xFFF0F0F0),
              suffixIconColor: colorScheme.onSurface,
              prefixIconColor: colorScheme.onSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : AppTheme.lightCard,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radiusLg),
                ),
                borderSide: BorderSide(
                  color:
                      colorScheme.brightness == Brightness.dark
                          ? colorScheme.surface
                          : const Color(0xFFF0F0F0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
