import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/presentation/screens/otpscreen.dart';
import 'package:organicplants/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:organicplants/features/auth/presentation/widgets/terms_and_policy_text.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/skip_button.dart';

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
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    void login() {
      if (formKey.currentState!.validate()) {
        auth.verifyPhoneNumber(
          phoneNumber: "+91${number.text}",
          verificationCompleted: (_) {
            CustomSnackBar.showSuccess(context, "Verification Completed! 🎉");
          },
          verificationFailed: (e) {
            CustomSnackBar.showError(context, "Verification Failed! ❌");
          },
          codeSent: (String verificationId, int? resendToken) {
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
            CustomSnackBar.showError(context, "Code Auto Retrieval Timeout! ❌");
          },
        );
      } else {
        CustomSnackBar.showError(context, "Please enter a valid phone number");
      }
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Do you want to exit the app?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Yes"),
                  ),
                ],
              ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSizes.paddingSm),
              child: SkipButton(
                textColor: AppTheme.primaryColor,
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EntryScreen()),
                    ),
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
                          style: textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/ltree.png',
                    width: 0.3.sw,
                    height: 0.2.sh,
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
                          CustomButton(
                            ontap: login,
                            backgroundColor: colorScheme.primary,
                            text: 'Continue',
                            //textColor: colorScheme.onPrimary,
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
