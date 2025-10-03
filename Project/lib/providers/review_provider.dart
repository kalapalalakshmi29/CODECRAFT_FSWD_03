import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/review.dart';

class ReviewProvider with ChangeNotifier {
  final Map<String, List<Review>> _reviews = {};

  List<Review> getReviewsForProduct(String productId) {
    return _reviews[productId] ?? [];
  }

  double getAverageRating(String productId) {
    final productReviews = _reviews[productId] ?? [];
    if (productReviews.isEmpty) return 4.5; // Default rating
    
    final totalRating = productReviews.fold(0.0, (sum, review) => sum + review.rating);
    return totalRating / productReviews.length;
  }

  void addReview(String productId, String userName, double rating, String comment) {
    final review = Review(
      id: ObjectId().toHexString(),
      productId: productId,
      userName: userName,
      rating: rating,
      comment: comment,
      date: DateTime.now(),
    );

    if (_reviews[productId] == null) {
      _reviews[productId] = [];
    }
    
    _reviews[productId]!.add(review);
    notifyListeners();
  }

  void loadSampleReviews() {
    // Add some sample reviews for demonstration
    final sampleReviews = [
      {'userName': 'Priya Sharma', 'rating': 5.0, 'comment': 'Excellent quality! Fresh and tasty.'},
      {'userName': 'Raj Kumar', 'rating': 4.5, 'comment': 'Good product, fast delivery.'},
      {'userName': 'Anita Singh', 'rating': 4.0, 'comment': 'Value for money. Will order again.'},
      {'userName': 'Vikram Patel', 'rating': 5.0, 'comment': 'Best quality I have found online!'},
      {'userName': 'Meera Gupta', 'rating': 4.5, 'comment': 'Fresh products, good packaging.'},
    ];

    // Add reviews to first few products
    for (int i = 0; i < 5; i++) {
      final productId = 'product_$i';
      for (final reviewData in sampleReviews.take(3)) {
        addReview(
          productId,
          reviewData['userName'] as String,
          reviewData['rating'] as double,
          reviewData['comment'] as String,
        );
      }
    }
  }
}