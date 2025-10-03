import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.orders;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Orders', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No orders yet', style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[600])),
                  Text('Place an order to track it here', style: GoogleFonts.poppins(color: Colors.grey[500])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order #${order.id.substring(0, 8)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(order.status, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Total: ₹${order.totalAmount.toStringAsFixed(0)}', style: GoogleFonts.poppins()),
                        Text('Date: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}', style: GoogleFonts.poppins(color: Colors.grey[600])),
                        const SizedBox(height: 12),
                        _buildOrderProgress(order.status),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Confirmed':
        return Colors.blue;
      case 'Preparing':
        return Colors.purple;
      case 'Shipped':
        return Colors.indigo;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildOrderProgress(String currentStatus) {
    final steps = ['Processing', 'Confirmed', 'Preparing', 'Shipped', 'Delivered'];
    final currentIndex = steps.indexOf(currentStatus);
    
    return Row(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isCompleted = index <= currentIndex;
        final isCurrent = index == currentIndex;
        
        return Expanded(
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? const Color(0xFF2E7D32) : Colors.grey[300],
                ),
                child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 12) : null,
              ),
              if (index < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? const Color(0xFF2E7D32) : Colors.grey[300],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}