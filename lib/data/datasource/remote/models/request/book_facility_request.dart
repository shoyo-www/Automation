
import 'dart:convert';

BookFacilitiesRequest bookFacilitiesRequestFromJson(String str) => BookFacilitiesRequest.fromJson(json.decode(str));

String bookFacilitiesRequestToJson(BookFacilitiesRequest data) => json.encode(data.toJson());

class BookFacilitiesRequest {
  String hotelId;
  String facilityId;
  String facilityTypeId;
  DateTime bookingDate;
  int numberOfGuests;

  BookFacilitiesRequest({
    required this.hotelId,
    required this.facilityId,
    required this.facilityTypeId,
    required this.bookingDate,
    required this.numberOfGuests,
  });

  factory BookFacilitiesRequest.fromJson(Map<String, dynamic> json) => BookFacilitiesRequest(
    hotelId: json["hotelId"],
    facilityId: json["facilityId"],
    facilityTypeId: json["facilityTypeId"],
    bookingDate: DateTime.parse(json["bookingDate"]),
    numberOfGuests: json["numberOfGuests"],
  );

  Map<String, dynamic> toJson() => {
    "hotelId": hotelId,
    "facilityId": facilityId,
    "facilityTypeId": facilityTypeId,
    "bookingDate": bookingDate.toIso8601String(),
    "numberOfGuests": numberOfGuests,
  };
}
