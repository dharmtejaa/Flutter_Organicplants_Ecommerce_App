import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/profile/presentation/screens/add_edit_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  // Refactor addresses to ValueNotifier
  final ValueNotifier<List<Map<String, String>>> addresses = ValueNotifier([
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
  ]);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Addresses', style: textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMd),
        child: ValueListenableBuilder<List<Map<String, String>>>(
          valueListenable: addresses,
          builder: (context, addressList, _) {
            return addressList.isEmpty
                ? Center(
                  child: Text(
                    'No addresses found. Add a new address!',
                    style: textTheme.bodyLarge,
                  ),
                )
                : ListView.separated(
                  itemCount: addressList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final addr = addressList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.paddingMd),
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
                                    style: textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    addr['address'] ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    addr['phone'] ?? '',
                                    style: textTheme.bodyMedium,
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
                                      style: textTheme.labelMedium?.copyWith(
                                        color: colorScheme.primary,
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => AddEditAddressScreen(
                                              initialData: addr,
                                            ),
                                      ),
                                    );
                                  },
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: colorScheme.error,
                                  ),
                                  onPressed: () {
                                    final updated =
                                        List<Map<String, String>>.from(
                                          addressList,
                                        );
                                    updated.removeAt(index);
                                    addresses.value = updated;
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
            final updated = List<Map<String, String>>.from(addresses.value);
            updated.add(newAddress);
            addresses.value = updated;
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
