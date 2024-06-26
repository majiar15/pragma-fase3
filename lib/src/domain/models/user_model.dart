import 'dart:convert';

class UserModel {
    Address address;
    int id;
    String email;
    String username;
    String password;
    Name name;
    String phone;
    int v;

    UserModel({
        required this.address,
        required this.id,
        required this.email,
        required this.username,
        required this.password,
        required this.name,
        required this.phone,
        required this.v,
    });

    UserModel copyWith({
        Address? address,
        int? id,
        String? email,
        String? username,
        String? password,
        Name? name,
        String? phone,
        int? v,
    }) => 
        UserModel(
            address: address ?? this.address,
            id: id ?? this.id,
            email: email ?? this.email,
            username: username ?? this.username,
            password: password ?? this.password,
            name: name ?? this.name,
            phone: phone ?? this.phone,
            v: v ?? this.v,
        );

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    static List<UserModel> fromJsonList(List<dynamic> jsonList) {
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    }

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        address: Address.fromJson(json["address"]),
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: Name.fromJson(json["name"]),
        phone: json["phone"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "name": name.toJson(),
        "phone": phone,
        "__v": v,
    };
}

class Address {
    Geolocation geolocation;
    String city;
    String street;
    int number;
    String zipcode;

    Address({
        required this.geolocation,
        required this.city,
        required this.street,
        required this.number,
        required this.zipcode,
    });

    Address copyWith({
        Geolocation? geolocation,
        String? city,
        String? street,
        int? number,
        String? zipcode,
    }) => 
        Address(
            geolocation: geolocation ?? this.geolocation,
            city: city ?? this.city,
            street: street ?? this.street,
            number: number ?? this.number,
            zipcode: zipcode ?? this.zipcode,
        );

    factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        geolocation: Geolocation.fromJson(json["geolocation"]),
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "geolocation": geolocation.toJson(),
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
    };
}

class Geolocation {
    String lat;
    String long;

    Geolocation({
        required this.lat,
        required this.long,
    });

    Geolocation copyWith({
        String? lat,
        String? long,
    }) => 
        Geolocation(
            lat: lat ?? this.lat,
            long: long ?? this.long,
        );

    factory Geolocation.fromRawJson(String str) => Geolocation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json["lat"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
    };
}

class Name {
    String firstname;
    String lastname;

    Name({
        required this.firstname,
        required this.lastname,
    });

    Name copyWith({
        String? firstname,
        String? lastname,
    }) => 
        Name(
            firstname: firstname ?? this.firstname,
            lastname: lastname ?? this.lastname,
        );

    factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
    };
}
