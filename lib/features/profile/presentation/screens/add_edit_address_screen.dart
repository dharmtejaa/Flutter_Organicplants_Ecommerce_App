import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';

class AddEditAddressScreen extends StatefulWidget {
  final Map<String, String>? initialData;
  const AddEditAddressScreen({super.key, this.initialData});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late ValueNotifier<String> _typeNotifier;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialData?['name'] ?? '',
    );
    _addressController = TextEditingController(
      text: widget.initialData?['address'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initialData?['phone'] ?? '',
    );
    _typeNotifier = ValueNotifier<String>(
      widget.initialData?['type'] ?? 'Home',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _typeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialData == null ? 'Add Address' : 'Edit Address',
          style: textTheme.headlineSmall,
        ),
        
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Custom text field for name
              CustomTextField(
                hintText: "Name",
                controller: _nameController,
                keyboardType: TextInputType.name,
                fillColor: colorScheme.surface,
              ),
              SizedBox(height: 12.h),
              // Custom text field for address
              CustomTextField(
                hintText: "Address",
                controller: _addressController,
                maxLines: 2,
                keyboardType: TextInputType.streetAddress,
                fillColor: colorScheme.surface,
              ),
              SizedBox(height: 12.h),
              // Custom text field for phone number
              CustomTextField(
                hintText: "Phone",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                fillColor: colorScheme.surface,
                maxLength: 10,
              ),

              SizedBox(height: 12.h),
              ValueListenableBuilder<String>(
                valueListenable: _typeNotifier,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      fillColor: colorScheme.surface,

                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['Home', 'Work', 'Other']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) _typeNotifier.value = value;
                    },
                  );
                },
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CustomSnackBar.showSuccess(
                            context,
                            'Address saved successfully!',
                          );
                          Navigator.pop(context, {
                            'name': _nameController.text,
                            'address': _addressController.text,
                            'phone': _phoneController.text,
                            'type': _typeNotifier.value,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        textStyle: textTheme.labelLarge,
                      ),
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
