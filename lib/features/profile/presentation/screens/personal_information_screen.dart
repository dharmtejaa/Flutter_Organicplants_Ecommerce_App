import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/auth/logic/auth_service.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/logic/user_profile_provider.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/gesture_detector_button.dart';
import 'package:provider/provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late final UserProfileProvider userProfileProvider;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController(
    text: userProfileProvider.displayName,
  );
  late final TextEditingController emailController = TextEditingController(
    text: userProfileProvider.userEmail,
  );
  // final _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProfileProvider = Provider.of<UserProfileProvider>(
      context,
      listen: false,
    );
  }
  // final _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with current user data
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    // _phoneController.dispose();
    // _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information", style: textTheme.headlineMedium),

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetectorButton(
            onPressed: () {
              userProfileProvider.updateUserProfile(
                email: emailController.text.trim(),
                fullName: nameController.text.trim(),
                profileImageUrl: userProfileProvider.profileImageUrl,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntryScreen()),
              );
            },
            text: "Save",
            textColor: colorScheme.primary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSizes.paddingAllMd,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 50.r,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextButton.icon(
                      onPressed: _changeProfilePicture,
                      icon: Icon(Icons.camera_alt, color: colorScheme.primary),
                      label: Text(
                        "Change Photo",
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              // Form Fields
              CustomTextField(
                controller: nameController,
                hintText: "Full Name",
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                fillColor: colorScheme.surface,
              ),
              SizedBox(height: 16.h),
              // Email Field
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                fillColor: colorScheme.surface,
                enabled: false,
              ),
              //SizedBox(height: 16.h),
              // Phone Number Field
              // CustomTextField(
              //   hintText: "Phone Number",
              //   controller: _phoneController,
              //   prefixIcon: Icons.phone_outlined,
              //   keyboardType: TextInputType.phone,
              //   fillColor: colorScheme.surface,
              //   maxLength: 10,
              // ),
              //SizedBox(height: 16.h),
              // Date of Birth Field
              // CustomTextField(
              //   hintText: "01/01/1999",
              //   controller: _dateOfBirthController,
              //   prefixIcon: Icons.calendar_today_outlined,
              //   keyboardType: TextInputType.datetime,
              //   fillColor: colorScheme.surface,
              //   readOnly: true,
              // ),
              //SizedBox(height: 32.h),
              // Additional Information
              // Text(
              //   "Additional Information",
              //   style: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.w600,
              //     color: colorScheme.onSurface,
              //   ),
              // ),
              //SizedBox(height: 16.h),
              //gender
              // _buildDropdownField(
              //   label: "Gender",
              //   value: "Male",
              //   fillColor: colorScheme.surface,
              //   items: ["Male", "Female", "Other", "Prefer not to say"],
              //   onChanged: (value) {
              //     // Handle gender change
              //   },
              // ),
              //SizedBox(height: 16.h),
              // Preferred Contact Method
              // _buildDropdownField(
              //   label: "Preferred Contact Method",
              //   value: "Email",
              //   fillColor: colorScheme.surface,
              //   items: ["Email", "Phone", "SMS"],
              //   onChanged: (value) {
              //     // Handle contact method change
              //   },
              // ),
              SizedBox(height: 170.h),
              // Delete Account Section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Danger Zone",
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Once you delete your account, there is no going back. Please be certain.",
                      style: textTheme.bodyMedium,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        // Show a dialog to get the user's password
                        final passwordController = TextEditingController();
                        CustomDialog.showCustom(
                          context: context,
                          title: "Re-authenticate to Delete",
                          content: CustomTextField(
                            hintText: "Enter your password",
                            controller: passwordController,
                            obsecureText: true,
                          ),
                          confirmText: "Delete",
                          isDestructive: true,
                          onConfirm: () {
                            if (passwordController.text.isNotEmpty) {
                              AuthService.deleteAccount(
                                context,
                                password: passwordController.text,
                              );
                            } else {
                              CustomSnackBar.showError(
                                context,
                                "Password cannot be empty",
                              );
                            }
                          },
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                      ),
                      child: Text(
                        "Delete Account",
                        style: textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildDropdownField({
  //   required String label,
  //   required String value,
  //   required List<String> items,
  //   Color? fillColor,
  //   required Function(String?) onChanged,
  // }) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final textTheme = Theme.of(context).textTheme;
  //   return DropdownButtonFormField<String>(
  //     value: value,
  //     style: textTheme.bodyMedium,
  //     decoration: InputDecoration(
  //       fillColor:
  //           (fillColor ??
  //               (colorScheme.brightness == Brightness.dark
  //                   ? DarkThemeColors.darkCharcoal
  //                   : LightThemeColors.pureWhite)),
  //       labelText: label,

  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(AppSizes.radiusLg)),
  //         borderSide: BorderSide(color: colorScheme.surface),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(AppSizes.radiusLg)),
  //         borderSide: BorderSide(color: colorScheme.primary),
  //       ),
  //     ),
  //     items:
  //         items.map((String item) {
  //           return DropdownMenuItem<String>(value: item, child: Text(item));
  //         }).toList(),
  //     onChanged: onChanged,
  //   );
  // }

  void _changeProfilePicture() {
    CustomSnackBar.showInfo(
      context,
      "Profile picture change feature coming soon!",
      duration: Duration(seconds: 2),
    );
  }
}
