class Product {
  final int id;
  final String title;
  final String brand;
  final double price;
  final double discountPercentage;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.images,
  });

  double get discountedPrice => price * (1 - discountPercentage / 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0, // Handle null int
      title: json['title'] as String? ?? 'No Title', // Handle null String
      brand: json['brand'] as String? ?? 'Unknown Brand',
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Handle null double
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [], // Handle list
    );
  }
}