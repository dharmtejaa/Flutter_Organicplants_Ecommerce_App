class CartItemModel {
  final String plantId;
  final String plantName;
  final String imageUrl;
  final double originalPrice;
  final double offerPrice;
  final double discount;
  final int quantity;

  CartItemModel({
    required this.plantId,
    required this.plantName,
    required this.imageUrl,
    required this.originalPrice,
    required this.offerPrice,
    required this.discount,
    required this.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map, String uid) {
    return CartItemModel(
      plantId: map['plantId'],
      plantName: map['name'],
      imageUrl: map['imageUrl'],
      originalPrice: map['originalPrice'],
      offerPrice: map['offerPrice'],
      discount: map['discount'],
      quantity: map['quantity'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'plantId': plantId,
      'plantName': plantName,
      'imageUrl': imageUrl,
      'originalPrice': originalPrice,
      'offerPrice': offerPrice,
      'discount': discount,
      'quantity': quantity,
    };
  }
}
