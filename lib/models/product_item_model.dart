enum Productsize {
  S,
  M,
  L,
  xL,
  xxL;

  static Productsize fromString(String size) {
    switch (size.toUpperCase()) {
      case 'S':
        return Productsize.S;
      case 'M':
        return Productsize.M;
      case 'L':
        return Productsize.L;
      case 'XL':
        return Productsize.xL;
      case 'XXL':
        return Productsize.xxL;
      default:
        return Productsize.S;
    }
  }
}

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final String discription;
  final double price;
  final bool isfavourite;
  final String category;
  final double averageRate;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.discription =
        'Lorem Ipsum Lorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem Ipsum ',
    required this.price,
    this.isfavourite = false,
    required this.category,
    this.averageRate = 4.5,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? discription,
    double? price,
    bool? isfavourite,
    String? category,
    double? averagerate,
    int? quantity,
    Productsize? size,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      discription: discription ?? this.discription,
      price: price ?? this.price,
      isfavourite: isfavourite ?? this.isfavourite,
      category: category ?? this.category,
      averageRate: averagerate ?? averageRate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'discription': discription});
    result.addAll({'price': price});
    result.addAll({'category': category});
    result.addAll({'averageRate': averageRate});

    return result;
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      discription: map['discription'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      averageRate: map['averageRate']?.toDouble() ?? 0.0,
    );
  }
}

List<ProductItemModel> dummyproducts = [
  ProductItemModel(
    id: 'K434118okA3XH70vmCgI',
    name: 'Black Shoes',
    imgUrl: 'https://pngimg.com/d/men_shoes_PNG7475.png',
    price: 20,
    category: 'Shoes',
  ),
  ProductItemModel(
    id: '3p6nOiAbCwlKNZkme7t2',
    name: 'Trousers',
    imgUrl:
        'https://www.pngall.com/wp-content/uploads/2016/09/Trouser-Free-Download-PNG.png',
    price: 30,
    category: 'Clothes',
  ),
  ProductItemModel(
    id: 'Y4xM7ukLvqRsurgioQmN',
    name: 'Pack of Tomatoes',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/12/tomatopng.parspng.com-6.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'OHncCKAImAwC9jg9XPam',
    name: 'Pack of Potatoes',
    imgUrl: 'https://pngimg.com/d/potato_png2398.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: '7WqSYwiEbed0G05zM72u',
    name: 'Pack of Onions',
    imgUrl: 'https://pngimg.com/d/onion_PNG99213.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'NQwKrejnxOFcgAzdkoQm',
    name: 'Pack of Apples',
    imgUrl: 'https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'uIVHYv1tLpiC3Jwik8b0',
    name: 'Pack of Oranges',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/05/orangepng.parspng.com_-1.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'BOQKlAc0GlRZXOmzcs1l',
    name: 'Pack of Bananas',
    imgUrl:
        'https://static.vecteezy.com/system/resources/previews/015/100/096/original/bananas-transparent-background-free-png.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'atZHZfhF5glVKKO3XCtz',
    name: 'Pack of Mangoes',
    imgUrl: 'https://purepng.com/public/uploads/large/mango-tgy.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'jXDJxAUnBWJTXrOn5V1n',
    name: 'Sweet Shirt',
    imgUrl:
        'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
    price: 15,
    category: 'Clothes',
  ),
  ProductItemModel(
    id: 'PjORGdvg4dVIxnVjjhgB',
    name: 'T-shirt',
    imgUrl:
        'https://parspng.com/wp-content/uploads/2022/07/Tshirtpng.parspng.com_.png',
    price: 10,
    category: 'Clothes',
  ),
];
