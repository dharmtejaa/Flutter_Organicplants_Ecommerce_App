import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/auth/presentation/screens/loginscreen.dart';
import 'package:organicplants/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:organicplants/features/auth/presentation/widgets/terms_and_policy_text.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';

enum Gender {
  male('Male'),
  female('Female'),
  others('Other');

  final String label;
  const Gender(this.label);
}

class Basicdetails extends StatefulWidget {
  const Basicdetails({super.key});

  @override
  State<Basicdetails> createState() => _BasicdetailsState();
}

class _BasicdetailsState extends State<Basicdetails> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final ValueNotifier<Gender?> selectedGender = ValueNotifier<Gender?>(null);

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    dob.dispose();
    selectedGender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Loginscreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colorScheme.onSurface,
            size: AppSizes.fontXxl,
          ),
        ),
      ),
      body: Column(
        children: [
          /// TOP HEADER
          Padding(
            padding: EdgeInsets.only(
              left: AppSizes.paddingMd,
              bottom: AppSizes.paddingXs,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Basic ",
                    style: textTheme.displayLarge,
                    children: [
                      TextSpan(text: "Detials", style: textTheme.displayMedium),
                    ],
                  ),
                ),
                //Image.asset('assets/stree.png', width: 0.4.sw, height: 0.2.sh),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //text form field
                    Column(
                      children: [
                        SizedBox(height: 10.h),
                        CustomTextField(
                          hintText: "Name",
                          controller: userName,
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 5.h),
                        CustomTextField(
                          hintText: "Email",
                          controller: email,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 5.h),
                        CustomTextField(
                          hintText: "DD/MM/YYYY",
                          controller: dob, // ✅ Fixed controller
                          keyboardType: TextInputType.datetime,
                          prefixIcon: Icons.calendar_month,
                        ),
                        SizedBox(height: 10.h),
                        Text("Select Gender", style: textTheme.titleLarge),
                        ValueListenableBuilder<Gender?>(
                          valueListenable: selectedGender,
                          builder: (context, value, _) {
                            return Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceAround, // Adjust spacing between items
                              children:
                                  Gender.values.map((gender) {
                                    return Row(
                                      children: [
                                        Radio<Gender>(
                                          value: gender,
                                          groupValue: value,
                                          onChanged:
                                              (val) =>
                                                  selectedGender.value = val,
                                          activeColor: colorScheme.primary,
                                        ),
                                        Text(
                                          gender.label,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                    // push button to bottom
                    Column(
                      children: [
                        CustomButton(
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryScreen(),
                              ),
                            );
                          },
                          backgroundColor: colorScheme.primary,
                          text: 'Continue',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
