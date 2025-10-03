import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<String> createOrder(List<CartItem> items, double totalAmount) async {
    final orderId = ObjectId().toHexString();
    final trackingId = 'TRK${DateTime.now().millisecondsSinceEpoch}';
    
    final order = Order(
      id: orderId,
      items: items,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      trackingId: trackingId,
    );

    _orders.add(order);
    notifyListeners();
    
    // Simulate order processing
    _simulateOrderProgress(orderId);
    
    return orderId;
  }

  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  void _simulateOrderProgress(String orderId) {
    // Simulate order status updates
    Future.delayed(const Duration(seconds: 30), () {
      _updateOrderStatus(orderId, 'Confirmed');
    });
    
    Future.delayed(const Duration(minutes: 2), () {
      _updateOrderStatus(orderId, 'Preparing');
    });
    
    Future.delayed(const Duration(minutes: 5), () {
      _updateOrderStatus(orderId, 'Shipped');
    });
  }

  void _updateOrderStatus(String orderId, String status) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      // Create new order with updated status
      final oldOrder = _orders[orderIndex];
      final updatedOrder = Order(
        id: oldOrder.id,
        items: oldOrder.items,
        totalAmount: oldOrder.totalAmount,
        orderDate: oldOrder.orderDate,
        status: status,
        trackingId: oldOrder.trackingId,
      );
      _orders[orderIndex] = updatedOrder;
      notifyListeners();
    }
  }
}