import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // User Profile Data
  String _userName = "John Doe";
  String _userEmail = "john.doe@example.com";
  String _userPhone = "+91 98765 43210";
  String _userAvatar = ""; // URL for avatar image
  String _userAddress = "123 Garden Street, Plant City, PC 12345";
  final DateTime _userDob = DateTime(1990, 1, 1);
  final String _userGender = "Male";

  // App Settings
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _locationEnabled = true;
  String _language = "English";
  String _currency = "₹ INR";
  bool _smsNotifications = false;
  bool _deliveryReminders = true;
  bool _priceDrops = false;
  bool _newProducts = true;
  bool _plantCareTips = true;
  bool _appUpdates = true;
  bool _promotionalOffers = false;

  // Ecommerce Stats
  final int _totalOrders = 12;
  final int _wishlistItems = 8;
  final int _reviewsGiven = 5;
  double _loyaltyPoints = 1250.0;
  String _membershipTier = "Gold";

  // Order Management
  final List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> get orders => _orders;
  void addOrder(Map<String, dynamic> order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  void cancelOrder(String orderId) {
    final index = _orders.indexWhere((order) => order['id'] == orderId);
    if (index != -1) {
      _orders[index]['status'] = 'Cancelled';
      notifyListeners();
    }
  }

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  String get userAvatar => _userAvatar;
  String get userAddress => _userAddress;
  DateTime get userDob => _userDob;
  String get userGender => _userGender;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get emailNotifications => _emailNotifications;
  bool get pushNotifications => _pushNotifications;
  bool get locationEnabled => _locationEnabled;
  String get language => _language;
  String get currency => _currency;
  bool get smsNotifications => _smsNotifications;
  bool get deliveryReminders => _deliveryReminders;
  bool get priceDrops => _priceDrops;
  bool get newProducts => _newProducts;
  bool get plantCareTips => _plantCareTips;
  bool get appUpdates => _appUpdates;
  bool get promotionalOffers => _promotionalOffers;

  int get totalOrders => _totalOrders;
  int get wishlistItems => _wishlistItems;
  int get reviewsGiven => _reviewsGiven;
  double get loyaltyPoints => _loyaltyPoints;
  String get membershipTier => _membershipTier;

  // Methods to update user data
  void updateUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void updateUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void updateUserPhone(String phone) {
    _userPhone = phone;
    notifyListeners();
  }

  void updateUserAddress(String address) {
    _userAddress = address;
    notifyListeners();
  }

  void updateUserAvatar(String avatarUrl) {
    _userAvatar = avatarUrl;
    notifyListeners();
  }

  // Methods to update settings
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleEmailNotifications(bool value) {
    _emailNotifications = value;
    notifyListeners();
  }

  void togglePushNotifications(bool value) {
    _pushNotifications = value;
    notifyListeners();
  }

  void toggleLocation(bool value) {
    _locationEnabled = value;
    notifyListeners();
  }

  void updateLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void updateCurrency(String curr) {
    _currency = curr;
    notifyListeners();
  }

  void toggleSmsNotifications(bool value) {
    _smsNotifications = value;
    notifyListeners();
  }

  void toggleDeliveryReminders(bool value) {
    _deliveryReminders = value;
    notifyListeners();
  }

  void togglePriceDrops(bool value) {
    _priceDrops = value;
    notifyListeners();
  }

  void toggleNewProducts(bool value) {
    _newProducts = value;
    notifyListeners();
  }

  void togglePlantCareTips(bool value) {
    _plantCareTips = value;
    notifyListeners();
  }

  void toggleAppUpdates(bool value) {
    _appUpdates = value;
    notifyListeners();
  }

  void togglePromotionalOffers(bool value) {
    _promotionalOffers = value;
    notifyListeners();
  }

  // Methods to update stats
  void updateLoyaltyPoints(double points) {
    _loyaltyPoints = points;
    notifyListeners();
  }

  void updateMembershipTier(String tier) {
    _membershipTier = tier;
    notifyListeners();
  }

  // Helper methods
  String get formattedLoyaltyPoints => _loyaltyPoints.toStringAsFixed(0);
  String get membershipTierColor {
    switch (_membershipTier.toLowerCase()) {
      case 'platinum':
        return '#E5E4E2';
      case 'gold':
        return '#FFD700';
      case 'silver':
        return '#C0C0C0';
      case 'bronze':
        return '#CD7F32';
      default:
        return '#FFD700';
    }
  }
}
