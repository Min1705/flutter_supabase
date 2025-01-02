import 'package:flutter/material.dart';
import 'package:test_supabase/models/product_model.dart';
import '../models/cart_model.dart';
import '../services/supabase_service.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeScreen(
      {super.key, required this.onTap, required this.currentIndex});
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
    ShoppingCart spc = ShoppingCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronics List'),
      ),
      //      body: FutureBuilder<List<Map<String, dynamic>>>(
      body: FutureBuilder<List<Product>>(
        //future: _supabaseService.getAllProducts(),
        future: _supabaseService.getAllProductModel(),

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
                // onTap: () => _showProductDetail(product.cast<String, >()),
                child: Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Image.network(
                        product.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            // SizedBox(height: 5),
                            // Text('Description: ${product['description']}'),
                            const SizedBox(height: 5),
                            Text('Price: \$${product.price}'),
                            // SizedBox(height: 5),
                            // Text('Stock: ${product['stock_quantity']}'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              spc.addItemInCart(product as Product, 1);

                              // context.read<CartService>().addToCart(product.cast<String, >());
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
