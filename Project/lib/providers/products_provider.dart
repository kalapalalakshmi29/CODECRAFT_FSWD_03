import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/product.dart';
import '../services/database_service.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => [..._products];
  bool get isLoading => _isLoading;

  List<String> get categories => _products.map((p) => p.category).toSet().toList();

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _seedProducts();
    } catch (e) {
      print('Error loading products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _seedProducts() async {
    final sampleProducts = [
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Apples (Shimla)',
        description: 'Premium quality Shimla apples, crisp and sweet',
        price: 180.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlHKiUqPoldrdfYKH1yLt5-QyznG8YPgRhjA&s',
        category: 'Fruits',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Organic Bananas',
        description: 'Fresh organic bananas from Kerala farms',
        price: 60.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRi6LvwhrORX6xBA5s-vM-K36mQrTmFgQ13Q&s',
        category: 'Fruits',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Alphonso Mangoes',
        description: 'King of mangoes - Premium Alphonso from Ratnagiri',
        price: 450.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkjG-19CTFIEd_FuauH8y4A1S2cZugQges4g&s',
        category: 'Fruits',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Oranges',
        description: 'Juicy Nagpur oranges, rich in Vitamin C',
        price: 120.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRB2F_oJpf3YW-WDqN8rUKsAWDlBIkYBvBDSQ&s',
        category: 'Fruits',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Pomegranates',
        description: 'Fresh ruby red pomegranates from Maharashtra',
        price: 200.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Knc_zD0InLuoZWbQtAKGSP7lIU6VSJ8ZCg&s',
        category: 'Fruits',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Tomatoes',
        description: 'Farm fresh red tomatoes, perfect for cooking',
        price: 40.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiLQj1m5k21goPiI3crbOjglVdGeKx7yzTyw&s',
        category: 'Vegetables',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Onions (Nashik)',
        description: 'Premium quality Nashik onions, essential for Indian cooking',
        price: 35.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv-8gNDdM4yB-GOQqc0y1wUQmrnx58iPgdgg&s',
        category: 'Vegetables',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Potatoes',
        description: 'High quality potatoes from Punjab farms',
        price: 30.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMip29QDI8mc1byaVCdJ1SIUlL0TecjN2jsQ&s',
        category: 'Vegetables',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Green Chilies',
        description: 'Fresh green chilies, adds spice to your dishes',
        price: 80.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGv2iLJa86Xjpd6HRfh940fwYAg2lQBkOGKQ&s',
        category: 'Vegetables',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Ginger',
        description: 'Organic ginger root, perfect for tea and cooking',
        price: 150.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9WYq4nP1PbUAcJQjD7bNwlV_miN1K0LVmiQ&s',
        category: 'Vegetables',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Basmati Rice (1kg)',
        description: 'Premium aged Basmati rice from Punjab',
        price: 180.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-t7T_haRcFpFtvD7kZD9kKCXLF8O2R_LJDA&s',
        category: 'Rice & Grains',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Toor Dal (1kg)',
        description: 'High quality Arhar dal, protein rich',
        price: 120.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-1S7Bsvvq3NoUFxbRXFXDcA1DJ04BdZsgSQ&s',
        category: 'Rice & Grains',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Whole Wheat Flour (1kg)',
        description: 'Fresh ground whole wheat flour for rotis',
        price: 45.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQF5g6swrwN84kpHmdNR6Xcp5F9Spvf-IVPg&s',
        category: 'Rice & Grains',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Milk (1L)',
        description: 'Pure cow milk from local dairy farms',
        price: 60.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyHdf6Sko0iZI1FwvKNTpa_FnF9_Me5kpz6w&s',
        category: 'Dairy',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Paneer (250g)',
        description: 'Fresh homemade paneer, soft and creamy',
        price: 120.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAaigpdtMtkdwrBN-fvrSzMjcE8dmMuE1Wdw&s',
        category: 'Dairy',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Curd (500g)',
        description: 'Fresh homemade curd, thick and creamy',
        price: 40.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFWXnzLK7xsZ33rr1vZlwDEt_pgiR-8GmMhw&s',
        category: 'Dairy',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Turmeric Powder (100g)',
        description: 'Pure turmeric powder, essential Indian spice',
        price: 45.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROxToDNd3Z6hVy34wyA_YrXFJDwdmTdt_3EA&s',
        category: 'Spices',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Garam Masala (50g)',
        description: 'Authentic blend of Indian spices',
        price: 80.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSedczWzNmfriwFthKkZIxAL-_IvIws25mZ4w&s',
        category: 'Spices',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Cumin Seeds (100g)',
        description: 'Premium quality jeera for tempering',
        price: 120.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QE-eBNCaJSRF69ktS20Fjt8xu8y_xrPOKA&s',
        category: 'Spices',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Namkeen Mix (200g)',
        description: 'Crispy and spicy Indian snack mix',
        price: 85.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-_Z0TZyC6Zub-TXH8nNZbJU0T72Y9Rtjbag&s',
        category: 'Snacks',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Masala Peanuts (250g)',
        description: 'Roasted peanuts with Indian spices',
        price: 95.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbLEdnMq_p4HpiwroEqdjc1p26fUV3oeOI0g&s',
        category: 'Snacks',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Masala Chai (250g)',
        description: 'Premium blend tea with Indian spices',
        price: 150.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGQ2Fl2lplsm0jeFREtXhfSkDXdoKfJpI03Q&s',
        category: 'Beverages',
      ),
      Product(
        id: ObjectId().toHexString(),
        name: 'Fresh Coconut Water',
        description: 'Natural tender coconut water, refreshing drink',
        price: 35.00,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvlgFJbfrZD_JumbGpeho6DEoNBrjYe67BBQ&s',
        category: 'Beverages',
      ),
    ];

    _products = sampleProducts;
  }
}