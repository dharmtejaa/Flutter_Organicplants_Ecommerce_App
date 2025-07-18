import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactUsContent();
  }
}

class _ContactUsContent extends StatefulWidget {
  @override
  State<_ContactUsContent> createState() => _ContactUsContentState();
}

class _ContactUsContentState extends State<_ContactUsContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: textTheme.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSizes.paddingAllSm,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We would love to hear from you!',
                  style: textTheme.headlineMedium,
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  width: double.infinity,
                  controller: _nameController,
                  hintText: 'Name',
                  fillColor: colorScheme.surface,
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  width: double.infinity,
                  controller: _emailController,
                  hintText: 'Email',
                  fillColor: colorScheme.surface,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  width: double.infinity,
                  controller: _messageController,
                  hintText: 'Message',
                  fillColor: colorScheme.surface,
                  //prefixIcon: Icons.message,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  backgroundColor: colorScheme.primary,
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      CustomSnackBar.showSuccess(
                        context,
                        'Thank you for contacting us!',
                      );
                      _nameController.clear();
                      _emailController.clear();
                      _messageController.clear();
                    }
                  },
                  text: 'Submit',
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
