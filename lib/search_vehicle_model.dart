// To parse this JSON data, do
//
//     final searchVehicleModel = searchVehicleModelFromJson(jsonString);

import 'dart:convert';

SearchVehicleModel searchVehicleModelFromJson(String str) => SearchVehicleModel.fromJson(json.decode(str));

String searchVehicleModelToJson(SearchVehicleModel data) => json.encode(data.toJson());

class SearchVehicleModel {
    String id;
    String name;

    SearchVehicleModel({
        required this.id,
        required this.name,
    });

    factory SearchVehicleModel.fromJson(Map<String, dynamic> json) => SearchVehicleModel(
        id: json["Id"].toString(),
        name: json["Name"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
