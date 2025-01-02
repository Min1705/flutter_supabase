class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? imageUrl;
  final int? stockQuantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.stockQuantity,
  });

  // Hàm chuyển đổi từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['image_url'],
      stockQuantity: json['stockquantity'],
    );
  }

  // Hàm chuyển đổi từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image_url': imageUrl,
      'stockquantity': stockQuantity,
    };
  }
}
