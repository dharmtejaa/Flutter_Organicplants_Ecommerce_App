import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReturnsRefundsModel {
  final String returnId;
  final String orderId;
  final String date;
  final String status;
  final String reason;
  final List<ReturnItemModel> items;
  final String refundAmount;
  final String refundMethod;
  final DateTime createdAt;

  ReturnsRefundsModel({
    required this.returnId,
    required this.orderId,
    required this.date,
    required this.status,
    required this.reason,
    required this.items,
    required this.refundAmount,
    required this.refundMethod,
    required this.createdAt,
  });

  factory ReturnsRefundsModel.fromMap(Map<String, dynamic> map, String uid) {
    try {
      return ReturnsRefundsModel(
        returnId: map['returnId'] ?? '',
        orderId: map['orderId'] ?? '',
        date: map['date'] ?? '',
        status: map['status'] ?? 'Processing',
        reason: map['reason'] ?? '',
        items:
            (map['items'] as List? ?? [])
                .map((item) => ReturnItemModel.fromMap(item))
                .toList(),
        refundAmount: map['refundAmount'] ?? '₹0',
        refundMethod: map['refundMethod'] ?? 'Original Payment Method',
        createdAt:
            map['createdAt'] is Timestamp
                ? (map['createdAt'] as Timestamp).toDate()
                : DateTime.now(),
      );
    } catch (e) {
      debugPrint('Error parsing ReturnsRefundsModel from map: $e');
      debugPrint('Map data: $map');
      // Return a default item if parsing fails
      return ReturnsRefundsModel(
        returnId: map['returnId'] ?? '',
        orderId: map['orderId'] ?? '',
        date: map['date'] ?? '',
        status: map['status'] ?? 'Processing',
        reason: map['reason'] ?? '',
        items: [],
        refundAmount: map['refundAmount'] ?? '₹0',
        refundMethod: map['refundMethod'] ?? 'Original Payment Method',
        createdAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'returnId': returnId,
      'orderId': orderId,
      'date': date,
      'status': status,
      'reason': reason,
      'items': items.map((item) => item.toMap()).toList(),
      'refundAmount': refundAmount,
      'refundMethod': refundMethod,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ReturnsRefundsModel copyWith({
    String? returnId,
    String? orderId,
    String? date,
    String? status,
    String? reason,
    List<ReturnItemModel>? items,
    String? refundAmount,
    String? refundMethod,
    DateTime? createdAt,
  }) {
    return ReturnsRefundsModel(
      returnId: returnId ?? this.returnId,
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      items: items ?? this.items,
      refundAmount: refundAmount ?? this.refundAmount,
      refundMethod: refundMethod ?? this.refundMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReturnItemModel {
  final String name;
  final int quantity;
  final String price;
  final String? plantId;
  final String? imageUrl;

  ReturnItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    this.plantId,
    this.imageUrl,
  });

  factory ReturnItemModel.fromMap(Map<String, dynamic> map) {
    return ReturnItemModel(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? '₹0',
      plantId: map['plantId'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'plantId': plantId,
      'imageUrl': imageUrl,
    };
  }

  ReturnItemModel copyWith({
    String? name,
    int? quantity,
    String? price,
    String? plantId,
    String? imageUrl,
  }) {
    return ReturnItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      plantId: plantId ?? this.plantId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
