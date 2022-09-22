class Product {
  final String id;
  final String imageUrl;
  final String title;
  final String name;
  final String description;
  final String price;
  final String apply;
  final String size;
  bool isFavorite;
 
  final String expiry;
  final String type;
  final String skin;
  final String category;

  Product(
      {required this.title,
      required this.name,
      required this.expiry,
      required this.category,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.id,
      required this.apply,
      required this.size,
      required this.skin,
      required this.type,
      this.isFavorite = true});
}
