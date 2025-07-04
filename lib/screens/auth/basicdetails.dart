import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/screens/auth/loginscreen.dart';
import 'package:organicplants/screens/auth/views/components/custom_textfield.dart';
import 'package:organicplants/screens/entry%20screen/entry_screen.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/customButtons/custombutton.dart';
import 'package:organicplants/screens/auth/views/components/rich_text_line.dart';

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
                    style: TextStyle(
                      fontSize: AppSizes.fontXxl,
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Detials",
                        style: TextStyle(
                          fontSize: AppSizes.fontDisplay,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                //Image.asset('assets/ltree.png', width: 0.3.sw, height: 0.2.sh),
              ],
            ),
          ),

          /// EXPANDABLE BOTTOM CONTAINER
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: AppSizes.paddingMd,
                right: AppSizes.paddingMd,
                bottom: AppSizes.paddingSm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusLg),
                  topRight: Radius.circular(AppSizes.radiusLg),
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
                        SizedBox(height: 13.h),
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
                        SizedBox(height: 5.h),
                        Text(
                          "Select Gender",
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: AppSizes.fontMd,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
                                          style: TextStyle(
                                            fontSize: AppSizes.fontSm,
                                          ),
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
