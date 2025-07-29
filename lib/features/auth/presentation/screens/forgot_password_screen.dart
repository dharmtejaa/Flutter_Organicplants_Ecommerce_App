// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/logic/auth_service.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';
import 'package:organicplants/shared/buttons/submit_custom_buttons.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
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
                    text: "Forgot Password? \n",
                    style: textTheme.displayLarge,
                    children: [
                      TextSpan(
                        text:
                            "Don't worry! We'll send you a secure link\nto reset your password",
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // CachedNetworkImage(
                //   imageUrl:
                //       'https://res.cloudinary.com/daqvdhmw8/image/upload/v1753080572/ltree_hyjza1.png',
                //   width: 0.3.sw,
                //   height: 0.2.sh,
                //   cacheManager: MyCustomCacheManager.instance,
                // ),
              ],
            ),
          ),
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
                      //email field
                      CustomTextField(
                        hintText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: 10.h),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 3,
                      //         indent: 15,
                      //         endIndent: 10,
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 6.0,
                      //       ),
                      //       child: Text(
                      //         'Or',
                      //         style: textTheme.labelLarge?.copyWith(
                      //           color: colorScheme.onSurface,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 3,
                      //         indent: 10,
                      //         endIndent: 15,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 16.h),
                      // //coninue with google sign in
                      // SubmitCustomButtons(
                      //   width: 323.w,
                      //   ontap: () async {
                      //     await AuthService.signInWithGoogle(context);
                      //   },
                      //   backgroundColor: colorScheme.surfaceContainerHighest,
                      //   text: 'Continue with Google',
                      //   networkImage:
                      //       "https://res.cloudinary.com/daqvdhmw8/image/upload/v1753412480/google_gy8mpr.png",
                      //   textColor: colorScheme.onSurface,
                      //   isBorder: true,
                      //   //icon: Icons.google,
                      // ),
                      SizedBox(height: 400.h),
                      //sign up  button
                      SubmitCustomButtons(
                        width: 323.w,
                        ontap: () async {
                          if (formKey.currentState!.validate()) {
                            await AuthService.resetPassword(
                              context,
                              emailController.text.trim(),
                            );
                          }
                        },
                        backgroundColor: colorScheme.primary,
                        text: 'Reset Password',
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
    );
  }
}
