import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../widgets/bottom_navigation_bar.dart';
/*
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

 */

class CartScreen extends StatefulWidget {
  final String? email;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CartScreen({
    super.key,
    this.email, //Khởi tạo tham số email
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartService = Provider.of<CartService>(context, listen: false);
      if (widget.email != null) {
        cartService.fetchCartItems(widget.email!);
      } else {
        print('email is null, cannot fetch cart items!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          final cartItems = cartService.cartItems;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Giỏ hàng trống!'),
            );
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(item['product_name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số lượng: ${item['quantity']}'),
                      Text('Đơn giá: ${item['unit_price']} VND'),
                      Text('Thành tiền: ${item['total_price']} VND'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      cartService.removeFromCart(item);
                    },
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
