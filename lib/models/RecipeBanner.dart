class RecipeBanner {
  RecipeBanner({
    required this.name,
    required this.productId,
    required this.url,
  });

  factory RecipeBanner.fromJSON(Map<String, dynamic> map) => RecipeBanner(
        name: map['name'],
        productId: map['product_id'],
        url: map['url'],
      );

  final String name, productId, url;
}
