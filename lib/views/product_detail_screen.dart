import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(product['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Description: ${product['description']}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Price: \$${product['price']}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Stock: ${product['stock_quantity']}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Center(
            child: Image.network(
              product['image_url'],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Thêm logic cho nút Add to Cart ở đây
                Navigator.pop(context);
              },
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
