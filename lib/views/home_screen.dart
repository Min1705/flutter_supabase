import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/supabase_service.dart';
import '../services/cart_service.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeScreen({super.key, required this.onTap, required this.currentIndex});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SupabaseService _supabaseService = SupabaseService();

  void _showProductDetail(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ProductDetailScreen(product: product);
      },
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronics List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _supabaseService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => _showProductDetail(product),
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Image.network(
                        product['image_url'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['title'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            // SizedBox(height: 5),
                            // Text('Description: ${product['description']}'),
                            const SizedBox(height: 5),
                            Text('Price: \$${product['price']}'),
                            // SizedBox(height: 5),
                            // Text('Stock: ${product['stock_quantity']}'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<CartService>().addToCart(product);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
      ),
    );
  }
}
