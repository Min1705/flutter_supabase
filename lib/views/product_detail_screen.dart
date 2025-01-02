import 'package:flutter/material.dart';
import 'package:test_supabase/models/product_model.dart';

import '../models/cart_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    ShoppingCart spc = ShoppingCart();
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
          Text(product.title ?? '',
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Description: ${product.description}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Price: \$${product.price}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Stock: ${product.stockQuantity}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Center(
            child: Image.network(
              product.imageUrl ?? '',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                spc.addItemInCart(product as Product, 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart!'),
                    duration: const Duration(
                        milliseconds:
                            500), // Giảm thời gian hiển thị xuống 1 giây
                  ),
                );

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
