import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/screens/auth/otpscreen.dart';
import 'package:organicplants/screens/entry%20screen/entry_screen.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/components/custom_snackbar.dart';
import 'package:organicplants/widgets/customButtons/custombutton.dart';
import 'package:organicplants/screens/auth/views/components/custom_textfield.dart';
import 'package:organicplants/screens/auth/views/components/rich_text_line.dart';

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
    void login() {
      if (formKey.currentState!.validate()) {
        auth.verifyPhoneNumber(
          phoneNumber: "+91${number.text}",
          verificationCompleted: (_) {
            showCustomSnackbar(
              context: context,
              message: "Verification Completed! 🎉",
              type: SnackbarType.success,
            );
          },
          verificationFailed: (e) {
            showCustomSnackbar(
              context: context,
              message: "Verification Failed! ❌",
              type: SnackbarType.error,
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            showCustomSnackbar(
              context: context,
              message: 'Otp sentsuccessfully ',
              type: SnackbarType.success,
            );
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
            showCustomSnackbar(
              context: context,
              message: "Code Auto Retrieval Timeout! ❌",
              type: SnackbarType.error,
            );
          },
        );
      } else {
        showCustomSnackbar(
          context: context,
          message: "Please enter a valid phone number",
          type: SnackbarType.error,
        );
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
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntryScreen()),
                  ),
              child: Padding(
                padding: EdgeInsets.only(right: 0.04.sw),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: AppSizes.fontLg,
                    color: colorScheme.onSurface,
                    //fontWeight: FontWeight.w500,
                  ),
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
                      style: TextStyle(
                        fontSize: AppSizes.fontDisplay,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "to get Started",
                          style: TextStyle(
                            fontSize: AppSizes.fontXxl,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onSurface,
                          ),
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
                    topLeft: Radius.circular(AppSizes.radiusLg),
                    topRight: Radius.circular(AppSizes.radiusLg),
                  ),
                  color: colorScheme.surface,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),
                      CustomTextField(
                        hintText: 'Number',
                        controller: number,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "You'll receive an OTP on the number above.",
                        style: TextStyle(
                          fontSize: AppSizes.fontSm,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      const Spacer(), // push button to bottom
                      CustomButton(
                        ontap: login,
                        backgroundColor: colorScheme.primary,
                        text: 'Continue',
                        textColor: AppTheme.lightBackground,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
