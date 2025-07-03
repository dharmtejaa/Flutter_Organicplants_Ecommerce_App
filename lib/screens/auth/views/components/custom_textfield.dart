import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/services/app_sizes.dart';

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

    switch (hintText.toLowerCase()) {
      case "email":
        if (!RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        ).hasMatch(value)) {
          return 'Enter a valid email!';
        }
        break;
      case "password":
      case "new password":
      case "confirm password":
        if (value.length < 8) return 'Password must be at least 8 characters!';
        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
          return 'Must contain uppercase letter!';
        }
        if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
          return 'Must contain a number!';
        }
        if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
          return 'Must contain a special character!';
        }
        break;
      case "phone":
        if (!RegExp(r"^\d{10,}$").hasMatch(value)) {
          return 'Enter a valid phone number!';
        }
        break;
      case "name":
        if (value.length < 3) return 'Name too short!';
        if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
          return 'Only letters allowed!';
        }
        break;
      default:
        return null;
    }

    // Optional: Match confirm password
    if (hintText.toLowerCase() == "confirm password" &&
        confirmPasswordController != null &&
        confirmPasswordController!.text != value) {
      return "Passwords do not match!";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
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
            validator: _validateInput,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
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
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                borderSide: BorderSide(color: Colors.green.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                borderSide: BorderSide(color: Colors.green.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                borderSide: BorderSide(color: Colors.green.shade400),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                borderSide: BorderSide.none,
              ),
              suffixIconColor: Colors.green.shade400,
              prefixIconColor: Colors.green.shade400,
            ),
          );
        },
      ),
    );
  }
}
