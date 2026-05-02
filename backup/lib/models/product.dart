class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final String community;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final bool isVerified;
  final bool hasTryOn;
  final String sellerName;
  bool isWishlisted;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.community,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.isVerified,
    required this.hasTryOn,
    required this.sellerName,
    this.isWishlisted = false,
  });

  double get discountPercent =>
      ((originalPrice - price) / originalPrice * 100).roundToDouble();

  Product copyWith({bool? isWishlisted}) {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      originalPrice: originalPrice,
      rating: rating,
      reviewCount: reviewCount,
      images: images,
      community: community,
      category: category,
      sizes: sizes,
      colors: colors,
      isVerified: isVerified,
      hasTryOn: hasTryOn,
      sellerName: sellerName,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}
