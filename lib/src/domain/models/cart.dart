import 'dart:convert';

class Cart {
    int id;
    int userId;
    DateTime date;
    List<ProductCart> products;
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
        List<ProductCart>? products,
        int? v,
    }) => 
        Cart(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            date: date ?? this.date,
            products: products ?? this.products,
            v: v ?? this.v,
        );

    factory Cart.fromJson(str) => Cart.fromMap(str);

    String toJson() => json.encode(toMap());

    static List<Cart> fromJsonList(List<dynamic> jsonList) {
      return jsonList.map((json) => Cart.fromJson(json)).toList();
    }

    factory Cart.fromMap(json) => Cart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<ProductCart>.from(json["products"].map((x) => ProductCart.fromMap(x))),
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

class ProductCart {
    int productId;
    int quantity;

    ProductCart({
        required this.productId,
        required this.quantity,
    });

    ProductCart copyWith({
        int? productId,
        int? quantity,
    }) => 
        ProductCart(
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
        );

    factory ProductCart.fromJson(String str) => ProductCart.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductCart.fromMap(Map<String, dynamic> json) => ProductCart(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
    };
}
