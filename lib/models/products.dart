class Products {
  final String id;
  final String title;
  final String descroption;
  final double price;
  final String url;
  final bool isFavorite;

  Products({
    required this.id,
    required this.title,
    required this.descroption,
    required this.price,
    required this.url,
    this.isFavorite = false,
  });
}
