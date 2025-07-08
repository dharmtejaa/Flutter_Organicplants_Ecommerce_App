import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialData == null ? 'Add Address' : 'Edit Address',
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a name'
                            : null,
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter an address'
                            : null,
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator:
                    (value) =>
                        value == null || value.length < 10
                            ? 'Enter a valid phone number'
                            : null,
              ),
              SizedBox(height: 16.h),
              ValueListenableBuilder<String>(
                valueListenable: _typeNotifier,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    decoration: InputDecoration(
                      labelText: 'Type',
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
              SizedBox(height: 28.h),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Address saved!')),
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
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
