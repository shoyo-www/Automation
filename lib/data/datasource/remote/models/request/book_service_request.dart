import 'dart:convert';

String bookServiceToJson(BookServiceRequest data) => json.encode(data.toJson());

class BookServiceRequest {
  final String? hotelId;
  final String? hotelFacilityId;
  final List<SubCategory>? subCategory;

  BookServiceRequest({
    this.hotelId,
    this.hotelFacilityId,
    this.subCategory,
  });


  Map<String, dynamic> toJson() => {
    "hotelId": hotelId,
    "hotelFacilityId": hotelFacilityId,
    "subCategory": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
  };
}

class SubCategory {
  final String? subCategoryId;
  final String? description;

  SubCategory({
    this.subCategoryId,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    "subCategoryId": subCategoryId,
    "description": description,
  };
}
