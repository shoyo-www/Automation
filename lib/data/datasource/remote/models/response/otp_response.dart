// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  OtpResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "type": type,
    "data": data?.toJson(),
  };
}

class Data {
  final User? user;
  final List<BookRoomDatum>? bookRoomData;
  final HotelData? hotelData;
  final String? token;

  Data({
    this.user,
    this.bookRoomData,
    this.hotelData,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    bookRoomData: json["bookRoomData"] == null ? [] : List<BookRoomDatum>.from(json["bookRoomData"]!.map((x) => BookRoomDatum.fromJson(x))),
    hotelData: json["hotelData"] == null ? null : HotelData.fromJson(json["hotelData"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "bookRoomData": bookRoomData == null ? [] : List<dynamic>.from(bookRoomData!.map((x) => x.toJson())),
    "hotelData": hotelData?.toJson(),
    "token": token,
  };
}

class BookRoomDatum {
  final String? id;
  final List<String>? customerIds;
  final bool? isCancelled;
  final bool? isDeleted;
  final String? hotelId;
  final String? roomId;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? totalGuests;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RoomData? roomData;

  BookRoomDatum({
    this.id,
    this.customerIds,
    this.isCancelled,
    this.isDeleted,
    this.hotelId,
    this.roomId,
    this.checkInDate,
    this.checkOutDate,
    this.totalGuests,
    this.createdAt,
    this.updatedAt,
    this.roomData,
  });

  factory BookRoomDatum.fromJson(Map<String, dynamic> json) => BookRoomDatum(
    id: json["_id"],
    customerIds: json["customerIds"] == null ? [] : List<String>.from(json["customerIds"]!.map((x) => x)),
    isCancelled: json["isCancelled"],
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    roomId: json["roomId"],
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"] == null ? null : DateTime.parse(json["checkOutDate"]),
    totalGuests: json["totalGuests"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    roomData: json["roomData"] == null ? null : RoomData.fromJson(json["roomData"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerIds": customerIds == null ? [] : List<dynamic>.from(customerIds!.map((x) => x)),
    "isCancelled": isCancelled,
    "isDeleted": isDeleted,
    "hotelId": hotelId,
    "roomId": roomId,
    "checkInDate": checkInDate?.toIso8601String(),
    "checkOutDate": checkOutDate?.toIso8601String(),
    "totalGuests": totalGuests,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "roomData": roomData?.toJson(),
  };
}

class RoomData {
  final String? id;
  final bool? isDeleted;
  final bool? isAvailable;
  final String? hotelId;
  final int? roomNumber;
  final int? occupancy;
  final int? price;
  final String? category;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RoomData({
    this.id,
    this.isDeleted,
    this.isAvailable,
    this.hotelId,
    this.roomNumber,
    this.occupancy,
    this.price,
    this.category,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isAvailable: json["isAvailable"],
    hotelId: json["hotelId"],
    roomNumber: json["roomNumber"],
    occupancy: json["occupancy"],
    price: json["price"],
    category: json["category"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isAvailable": isAvailable,
    "hotelId": hotelId,
    "roomNumber": roomNumber,
    "occupancy": occupancy,
    "price": price,
    "category": category,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class HotelData {
  final String? id;
  final bool? isDeleted;
  final List<String>? phone;
  final List<String>? email;
  final List<String>? images;
  final String? name;
  final Address? address;
  final String? description;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HotelData({
    this.id,
    this.isDeleted,
    this.phone,
    this.email,
    this.images,
    this.name,
    this.address,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) => HotelData(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    phone: json["phone"] == null ? [] : List<String>.from(json["phone"]!.map((x) => x)),
    email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    name: json["name"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    description: json["description"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "name": name,
    "address": address?.toJson(),
    "description": description,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  Address({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "postalCode": postalCode,
  };
}

class User {
  final String? id;
  final bool? isActive;
  final String? hotelId;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? alternatePhoneNumber;
  final String? email;
  final String? idType;
  final String? idDocument;
  final String? city;
  final String? state;
  final String? postalCode;
  final int? userType;
  final String? roomId;
  final int? customerStatus;
  final String? createdBy;

  User({
    this.id,
    this.isActive,
    this.hotelId,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.alternatePhoneNumber,
    this.email,
    this.idType,
    this.idDocument,
    this.city,
    this.state,
    this.postalCode,
    this.userType,
    this.roomId,
    this.customerStatus,
    this.createdBy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    isActive: json["isActive"],
    hotelId: json["hotelId"],
    name: json["name"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    phoneNumber: json["phoneNumber"],
    alternatePhoneNumber: json["alternatePhoneNumber"],
    email: json["email"],
    idType: json["idType"],
    idDocument: json["idDocument"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postalCode"],
    userType: json["userType"],
    roomId: json["roomId"],
    customerStatus: json["customerStatus"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isActive": isActive,
    "hotelId": hotelId,
    "name": name,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "phoneNumber": phoneNumber,
    "alternatePhoneNumber": alternatePhoneNumber,
    "email": email,
    "idType": idType,
    "idDocument": idDocument,
    "city": city,
    "state": state,
    "postalCode": postalCode,
    "userType": userType,
    "roomId": roomId,
    "customerStatus": customerStatus,
    "createdBy": createdBy,
  };
}
