class PromoBanner {
  PromoBanner({
    required this.name,
    required this.url,
  });

  factory PromoBanner.fromJSON(Map<String, dynamic> map) => PromoBanner(
        name: map['name'],
        url: map['url'],
      );

  final String name, url;
}
