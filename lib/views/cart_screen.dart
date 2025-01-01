import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../widgets/bottom_navigation_bar.dart';

class CartScreen extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CartScreen({super.key, required this.onTap, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          final cartItems = cartService.cartItems;

          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return ListTile(
                leading: Image.network(
                  product['image_url'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product['title']),
                subtitle: Text('Price: \$${product['price']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartService.removeFromCart(product);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
