import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/auth/presentation/screens/basicdetails.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';
import 'package:organicplants/features/auth/presentation/widgets/terms_and_policy_text.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/skip_button.dart';
import 'package:pinput/pinput.dart';

class OTPscreen extends StatefulWidget {
  final String? text;
  final String? verificationId;
  const OTPscreen({super.key, this.text, this.verificationId});

  @override
  // ignore: library_private_types_in_public_api
  _OTPscreenState createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  ValueNotifier<int> timerValue = ValueNotifier(30);
  Timer? _timer;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    _timer?.cancel();
    timerValue.dispose();
    super.dispose();
  }

  void startTimer() {
    timerValue.value = 30;
    _isResendEnabled = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value == 0) {
        _isResendEnabled = true;
        timer.cancel();
      } else {
        timerValue.value--;
      }
    });
  }

  Future<void> verifyOTP() async {
    if (controller.text.length == 6) {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId!,
        smsCode: controller.text.trim(),
      );
      try {
        await auth.signInWithCredential(credential);
        CustomSnackBar.showSuccess(
          // ignore: use_build_context_synchronously
          context,
          'OTP Verified Successfully! 🎉',
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const Basicdetails()),
          );
        });
      } catch (e) {
        CustomSnackBar.showError(
          // ignore: use_build_context_synchronously
          context,
          'OTP verification failed',
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 70.h,
      textStyle: textTheme.headlineLarge,
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 60.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
      ],
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 60.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: colorScheme.onSurface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          SkipButton(
            onPressed:
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginscreen()),
                ),
          ),
          //SizedBox(width: 10.w),
        ],
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const Loginscreen()),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_outlined,
        //       color: colorScheme.primary,
        //       size: AppSizes.fontXxl,
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppSizes.paddingSymmetricMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: "OTP ",
                      style: textTheme.displayLarge,
                      children: [
                        TextSpan(
                          text: "Verification",
                          style: textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  RichText(
                    text: TextSpan(
                      text:
                          "Please enter the verification code we've sent you on\n+91-${widget.text} ",
                      style: textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Loginscreen(),
                                    ),
                                  );
                                },
                          text: "Edit",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 55.h),
            Expanded(
              child: Container(
                padding: AppSizes.paddingSymmetricMd,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusXxl),
                    topRight: Radius.circular(AppSizes.radiusXxl),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: AppSizes.marginSm,
                              vertical: AppSizes.marginLg,
                            ),
                            child: Pinput(
                              length: 6,
                              controller: controller,
                              keyboardType: TextInputType.number,
                              focusNode: focusNode,
                              autofocus: true,
                              pinAnimationType: PinAnimationType.slide,
                              defaultPinTheme: defaultPinTheme,
                              showCursor: true,
                              cursor: cursor,
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: colorScheme.primary,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                              preFilledWidget: preFilledWidget,
                              hapticFeedbackType:
                                  HapticFeedbackType.mediumImpact,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: ValueListenableBuilder<int>(
                            valueListenable: timerValue,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap:
                                    _isResendEnabled
                                        ? () {
                                          startTimer();
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("OTP resent"),
                                            ),
                                          );
                                        }
                                        : null,
                                child: Text(
                                  _isResendEnabled
                                      ? "Resend Code"
                                      : "Resend Code in $value s",
                                  style:
                                      _isResendEnabled
                                          ? textTheme.bodyMedium?.copyWith(
                                            color: colorScheme.primary,
                                          )
                                          : textTheme.bodyMedium,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    //const Spacer(),
                    Column(
                      children: [
                        CustomButton(
                          ontap: verifyOTP,
                          backgroundColor: colorScheme.primary,
                          text: 'Verify Code',
                          textColor: colorScheme.onPrimary,
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
                    //SizedBox(height: 0.02.sh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
