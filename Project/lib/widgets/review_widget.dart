import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/review_provider.dart';

class ReviewWidget extends StatelessWidget {
  final String productId;

  const ReviewWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final reviews = reviewProvider.getReviewsForProduct(productId);
    final averageRating = reviewProvider.getAverageRating(productId);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Reviews', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            RatingBarIndicator(
              rating: averageRating,
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 16,
            ),
            const SizedBox(width: 8),
            Text('(${reviews.length})', style: GoogleFonts.poppins(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 16),
        if (reviews.isEmpty)
          Text('No reviews yet. Be the first to review!', style: GoogleFonts.poppins(color: Colors.grey[600]))
        else
          ...reviews.take(3).map((review) => _buildReviewItem(review.userName, review.rating, review.comment)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showAddReviewDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
          ),
          child: Text('Add Review', style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String userName, double rating, String comment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(userName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                const Spacer(),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 16,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment, style: GoogleFonts.poppins()),
          ],
        ),
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    double rating = 5.0;
    final commentController = TextEditingController();
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Review', style: GoogleFonts.poppins()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Write your review...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              if (commentController.text.isNotEmpty) {
                reviewProvider.addReview(
                  productId,
                  'Customer',
                  rating,
                  commentController.text,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Review added successfully!', style: GoogleFonts.poppins()),
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                );
              }
            },
            child: Text('Submit', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}