import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:test_supabase/services/banner_service.dart';
import 'package:test_supabase/views/product_detail_screen.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import '../widgets/bottom_navigation_bar.dart';

class BannerScreen extends StatefulWidget {
  final BannerService bannerService;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BannerScreen({
    super.key,
    required this.bannerService,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final SupabaseService _supabaseService = SupabaseService();

  late Future<List<String>> _bannerUrls;
  late Future<List<Product>> _productList;
  int _categoryId = 1;

  @override
  void initState() {
    super.initState();
    _bannerUrls = widget.bannerService.getBanner();
    _productList = _supabaseService.getProductByCategoryId(_categoryId);
  }

  void _getProducts(int categoryId) {
    setState(() {
      _categoryId = categoryId;
      _productList = _supabaseService.getProductByCategoryId(categoryId);
    });
  }

  void _showProductDetail(Product product) {
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
    ShoppingCart shoppingCart = ShoppingCart();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner Screen"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Banner Slideshow
          FutureBuilder<List<String>>(
            future: _bannerUrls,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading banners.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No banners found.'));
              }

              final bannerUrls = snapshot.data!;
              return SizedBox(
                height: 175,
                child: ImageSlideshow(
                  autoPlayInterval: 2000,
                  isLoop: true,
                  children: bannerUrls.map((url) {
                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          // Category Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _getProducts(1),
                child: const Text('Laptop'),
              ),
              ElevatedButton(
                onPressed: () => _getProducts(2),
                child: const Text('PC'),
              ),
              ElevatedButton(
                onPressed: () => _getProducts(3),
                child: const Text('Phone'),
              ),
              ElevatedButton(
                onPressed: () => _getProducts(4),
                child: const Text('Ipad'),
              ),
            ],
          ),
          // Product List
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading products.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                final products = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () => _showProductDetail(product),
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            product.title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Price: \$${product.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              shoppingCart.addItemInCart(product, 1);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${product.title} added to cart!'),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
      ),
    );
  }
}
