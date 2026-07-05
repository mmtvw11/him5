class FormatUtils {
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  static String formatDiscount(double discount) {
    return '-${discount.toStringAsFixed(0)}%';
  }

  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String formatStock(int stock) {
    if (stock == 0) return 'Out of Stock';
    if (stock < 5) return 'Only $stock left';
    return 'In Stock';
  }

  static String truncateText(String text, int length) {
    if (text.length <= length) return text;
    return '${text.substring(0, length)}...';
  }
}
