import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  static const String connectionString = 'mongodb://localhost:27017/local_store';
  static Db? _db;
  static DbCollection? _productsCollection;
  static DbCollection? _ordersCollection;

  static Future<void> connect() async {
    try {
      _db = Db(connectionString);
      await _db!.open();
      _productsCollection = _db!.collection('products');
      _ordersCollection = _db!.collection('orders');
      print('Connected to MongoDB');
    } catch (e) {
      print('Failed to connect to MongoDB: $e');
    }
  }

  static DbCollection? get products => _productsCollection;
  static DbCollection? get orders => _ordersCollection;

  static Future<void> close() async {
    await _db?.close();
  }
}