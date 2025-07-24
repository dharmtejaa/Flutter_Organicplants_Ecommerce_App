import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/presentation/screens/otpscreen.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/features/auth/presentation/widgets/terms_and_policy_text.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/gesture_detector_button.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController number = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final countryCode = "+91";

  // Add ValueNotifier for state management
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isPhoneValid = ValueNotifier(false);
  final ValueNotifier<String> _errorMessage = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    number.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = number.text.trim();
    _isPhoneValid.value =
        phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone);
    _errorMessage.value = '';
  }

  @override
  void dispose() {
    number.removeListener(_validatePhone);
    _isLoading.dispose();
    _isPhoneValid.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void login() {
      if (!_isPhoneValid.value) {
        _errorMessage.value = "Please enter a valid 10-digit phone number";
        return;
      }

      _isLoading.value = true;
      _errorMessage.value = '';

      auth.verifyPhoneNumber(
        phoneNumber: "+91${number.text}",
        verificationCompleted: (_) {
          _isLoading.value = false;
          CustomSnackBar.showSuccess(context, "Verification Completed! 🎉");
        },
        verificationFailed: (e) {
          _isLoading.value = false;
          _errorMessage.value = "Verification Failed: ${e.message}";
          CustomSnackBar.showError(context, "Verification Failed! ❌");
        },
        codeSent: (String verificationId, int? resendToken) {
          _isLoading.value = false;
          CustomSnackBar.showSuccess(context, 'OTP sent successfully');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => OTPscreen(
                    verificationId: verificationId,
                    text: number.text,
                  ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (e) {
          _isLoading.value = false;
          _errorMessage.value = "Code Auto Retrieval Timeout!";
          // CustomSnackBar.showError(context, "Code Auto Retrieval Timeout! ❌");
        },
      );
    }

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
        resizeToAvoidBottomInset: true,
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
            /// TOP HEADER
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
                      text: "Login \n",
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

            /// EXPANDABLE BOTTOM CONTAINER
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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          CustomTextField(
                            hintText: 'Number',
                            controller: number,
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icons.phone_outlined,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "  You'll receive an OTP on the number above.",
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                      //const Spacer(), // push button to bottom
                      Column(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: _isLoading,
                            builder: (context, isLoading, child) {
                              return ValueListenableBuilder<String>(
                                valueListenable: _errorMessage,
                                builder: (context, errorMessage, child) {
                                  return Column(
                                    children: [
                                      if (errorMessage.isNotEmpty)
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10.h,
                                          ),
                                          child: Text(
                                            errorMessage,
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                  color: colorScheme.error,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      CustomButton(
                                        ontap: isLoading ? null : login,
                                        backgroundColor:
                                            isLoading
                                                ? colorScheme.onSurfaceVariant
                                                : colorScheme.primary,
                                        text:
                                            isLoading
                                                ? 'Sending OTP...'
                                                : 'Continue',
                                        //textColor: colorScheme.onPrimary,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingSm,
                            ),
                            child: RichTextLine(),
                          ),
                        ],
                      ),
                    ],
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
