class ProductModel {
  final int? id;
  final String? title;
  double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        price = double.parse(json['price'].toString()),
        description = json['description'] as String?,
        category = json['category'] as String?,
        image = json['image'] as String?,
        rating = (json['rating'] as Map<String, dynamic>) != null
            ? Rating.fromJson(json['rating'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson()
      };
}

class Rating {
  final double? rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(Map<String, dynamic> json)
      : rate = double.parse(json['rate'].toString()),
        count = json['count'] as int?;

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
}
