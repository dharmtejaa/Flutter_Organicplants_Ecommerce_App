import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/profile/presentation/screens/add_edit_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  // Placeholder address data
  List<Map<String, String>> addresses = [
    {
      'name': 'John Doe',
      'address': '123 Green Street, Garden Colony, Mumbai, 400001',
      'phone': '+91 98765 43210',
      'type': 'Home',
    },
    {
      'name': 'Jane Smith',
      'address': '456 Blue Avenue, Lake City, Pune, 411001',
      'phone': '+91 91234 56789',
      'type': 'Work',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child:
            addresses.isEmpty
                ? Center(
                  child: Text(
                    'No addresses found. Add a new address!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
                : ListView.separated(
                  itemCount: addresses.length,
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final addr = addresses[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              addr['type'] == 'Home' ? Icons.home : Icons.work,
                              color: colorScheme.primary,
                              size: 28.w,
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addr['name'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    addr['address'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    addr['phone'] ?? '',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withOpacity(
                                        0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      addr['type'] ?? '',
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    // TODO: Edit address
                                  },
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: colorScheme.error,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                  },
                                  tooltip: 'Delete',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newAddress = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditAddressScreen()),
          );
          if (newAddress != null && newAddress is Map<String, String>) {
            setState(() {
              addresses.add(newAddress);
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Address added!')));
          }
        },
        icon: Icon(Icons.add_location_alt_rounded),
        label: Text('Add Address'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }
}
