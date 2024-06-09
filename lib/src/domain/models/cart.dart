import 'dart:convert';

class Cart {
    int id;
    int userId;
    DateTime date;
    List<Product> products;
    int v;

    Cart({
        required this.id,
        required this.userId,
        required this.date,
        required this.products,
        required this.v,
    });

    Cart copyWith({
        int? id,
        int? userId,
        DateTime? date,
        List<Product>? products,
        int? v,
    }) => 
        Cart(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            date: date ?? this.date,
            products: products ?? this.products,
            v: v ?? this.v,
        );

    factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "__v": v,
    };
}

class Product {
    int productId;
    int quantity;

    Product({
        required this.productId,
        required this.quantity,
    });

    Product copyWith({
        int? productId,
        int? quantity,
    }) => 
        Product(
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
        );

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
    };
}
