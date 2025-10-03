import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../providers/auth_provider.dart';
import '../models/user.dart';

class AddressScreen extends StatefulWidget {
  final bool isCheckout;
  
  const AddressScreen({super.key, this.isCheckout = false});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Address? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final addresses = authProvider.currentUser?.addresses ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCheckout ? 'Select Address' : 'Manage Addresses', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: addresses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_off, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('No addresses added', style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[600])),
                        Text('Add an address to continue', style: GoogleFonts.poppins(color: Colors.grey[500])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: RadioListTile<Address>(
                          value: address,
                          groupValue: _selectedAddress ?? authProvider.defaultAddress,
                          onChanged: widget.isCheckout ? (value) {
                            setState(() {
                              _selectedAddress = value;
                            });
                          } : null,
                          title: Text(address.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${address.addressLine1}, ${address.addressLine2}', style: GoogleFonts.poppins()),
                              Text('${address.city}, ${address.state} - ${address.pincode}', style: GoogleFonts.poppins()),
                              Text('Phone: ${address.phone}', style: GoogleFonts.poppins(color: Colors.grey[600])),
                              if (address.isDefault)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E7D32),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('Default', style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
                                ),
                            ],
                          ),
                          activeColor: const Color(0xFF2E7D32),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showAddAddressDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Add New Address', style: GoogleFonts.poppins()),
                  ),
                ),
                if (widget.isCheckout && addresses.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, _selectedAddress ?? authProvider.defaultAddress);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Continue with Selected Address', style: GoogleFonts.poppins()),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressLine1Controller = TextEditingController();
    final addressLine2Controller = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final pincodeController = TextEditingController();
    bool isDefault = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Address', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressLine1Controller,
                decoration: const InputDecoration(labelText: 'Address Line 1', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressLine2Controller,
                decoration: const InputDecoration(labelText: 'Address Line 2 (Optional)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(labelText: 'State', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pincodeController,
                decoration: const InputDecoration(labelText: 'Pincode', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  title: Text('Set as default address', style: GoogleFonts.poppins()),
                  value: isDefault,
                  onChanged: (value) {
                    setState(() {
                      isDefault = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  addressLine1Controller.text.isNotEmpty &&
                  cityController.text.isNotEmpty &&
                  stateController.text.isNotEmpty &&
                  pincodeController.text.isNotEmpty) {
                
                final address = Address(
                  id: mongo.ObjectId().toHexString(),
                  name: nameController.text,
                  phone: phoneController.text,
                  addressLine1: addressLine1Controller.text,
                  addressLine2: addressLine2Controller.text,
                  city: cityController.text,
                  state: stateController.text,
                  pincode: pincodeController.text,
                  isDefault: isDefault,
                );

                Provider.of<AuthProvider>(context, listen: false).addAddress(address);
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Address added successfully!', style: GoogleFonts.poppins()),
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                );
              }
            },
            child: Text('Add Address', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}