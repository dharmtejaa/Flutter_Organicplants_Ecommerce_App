// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/logic/auth_service.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';
import 'package:organicplants/shared/buttons/submit_custom_buttons.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/widgets/gesture_detector_button.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await CustomDialog.showConfirmation(
              context: context,
              title: "Are you sure?",
              content: "Do you want to exit the app?",
              confirmText: "Yes, Exit",
              cancelText: "No, Stay",
              icon: Icons.exit_to_app_outlined,
              iconColor: Theme.of(context).colorScheme.error,
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSizes.paddingSm),
              child: GestureDetectorButton(
                textColor: AppTheme.primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntryScreen()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // TOP HEADER
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.paddingMd,
                bottom: AppSizes.paddingSm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Sign Up \n",
                      style: textTheme.displayLarge,
                      children: [
                        TextSpan(
                          text: "to get Started",
                          style: textTheme.displayMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080572/ltree_hyjza1.png',
                    width: 0.3.sw,
                    height: 0.2.sh,
                    cacheManager: MyCustomCacheManager.instance,
                  ),
                ],
              ),
            ),
            // EXPANDABLE BOTTOM CONTAINER
            Expanded(
              child: Container(
                width: double.infinity,
                padding: AppSizes.paddingSymmetricMd,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusXxl),
                    topRight: Radius.circular(AppSizes.radiusXxl),
                  ),
                  color: colorScheme.surface,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 10.h),
                        //full name
                        CustomTextField(
                          hintText: 'Name',
                          controller: nameController,
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 10.h),
                        //email field
                        CustomTextField(
                          hintText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: 10.h),
                        //password filed
                        CustomTextField(
                          hintText: 'New Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: Icons.visibility_off_outlined,
                          obsecureText: true,
                        ),
                        SizedBox(height: 10.h),
                        //confirm password
                        CustomTextField(
                          hintText: 'Confirm Password',
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: Icons.visibility_off_outlined,
                          obsecureText: true,
                        ),
                        SizedBox(height: 10.h),
                        //phone number
                        //divider
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 3,
                                indent: 15,
                                endIndent: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Text(
                                'Or',
                                style: textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 3,
                                indent: 10,
                                endIndent: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        //coninue with google sign in
                        SubmitCustomButtons(
                          width: 323.w,
                          ontap: () async {
                            await AuthService.signInWithGoogle(context);
                          },
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          text: 'Continue with Google',
                          networkImage:
                              "https://res.cloudinary.com/daqvdhmw8/image/upload/v1753412480/google_gy8mpr.png",
                          textColor: colorScheme.onSurface,
                          isBorder: true,
                          //icon: Icons.google,
                        ),
                        SizedBox(height: 50.h),
                        //sign up  button
                        SubmitCustomButtons(
                          width: 323.w,
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              // Additional validation for password matching
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                CustomSnackBar.showWarning(
                                  context,
                                  'Passwords do not match!',
                                );
                                return;
                              }
                              await AuthService.signUpWithEmailAndPassword(
                                context,
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }
                          },
                          backgroundColor: colorScheme.primary,
                          text: 'Sign Up',
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingSm,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: textTheme.labelLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "LogIn",
                                  style: textTheme.labelLarge?.copyWith(
                                    color: AppTheme.primaryColor,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const Loginscreen(),
                                            ),
                                          );
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
