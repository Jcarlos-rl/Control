import 'dart:convert';

AmateriaModel amateriaModelFromJson(String str) => AmateriaModel.fromJson(json.decode(str));

String amateriaModelToJson(AmateriaModel data) => json.encode(data.toJson());

class AmateriaModel {
    String id;
    String matricula;

    AmateriaModel({
        this.id,
        this.matricula,
    });

    factory AmateriaModel.fromJson(Map<String, dynamic> json) => AmateriaModel(
        id: json["id"],
        matricula: json["matricula"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
    };
}