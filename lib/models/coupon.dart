class Coupon {
  final String id;
  final String code;
  final String title;
  final String description;
  final int discount;
  final String discountType; // 'percentage' or 'fixed'
  final int minAmount;
  final DateTime expiryDate;
  final List<String> applicableTo; // community names
  final bool isActive;

  Coupon({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
    required this.discountType,
    required this.minAmount,
    required this.expiryDate,
    required this.applicableTo,
    this.isActive = true,
  });

  String get displayDiscount {
    if (discountType == 'percentage') {
      return '${discount}% OFF';
    } else {
      return '₹${discount} OFF';
    }
  }

  bool get isExpired => expiryDate.isBefore(DateTime.now());
}
