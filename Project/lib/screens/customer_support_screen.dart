import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFF2E7D32)),
                title: Text('Call Us', style: GoogleFonts.poppins()),
                subtitle: Text('+91 1800-123-4567', style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: Color(0xFF2E7D32)),
                title: Text('Email Us', style: GoogleFonts.poppins()),
                subtitle: Text('support@freshmart.com', style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.chat, color: Color(0xFF2E7D32)),
                title: Text('Live Chat', style: GoogleFonts.poppins()),
                subtitle: Text('Chat with our support team', style: GoogleFonts.poppins()),
                onTap: () {
                  _showChatDialog(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.help, color: Color(0xFF2E7D32)),
                title: Text('FAQ', style: GoogleFonts.poppins()),
                subtitle: Text('Frequently Asked Questions', style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Live Chat', style: GoogleFonts.poppins()),
        content: Text('Chat feature coming soon!', style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}