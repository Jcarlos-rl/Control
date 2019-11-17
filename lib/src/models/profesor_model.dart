import 'dart:convert';

ProfesorModel profesorModelFromJson(String str) => ProfesorModel.fromJson(json.decode(str));

String profesorModelToJson(ProfesorModel data) => json.encode(data.toJson());

class ProfesorModel {
    String id;
    String correo;
    bool perfil;

    ProfesorModel({
        this.id,
        this.correo,
        this.perfil,
    });

    factory ProfesorModel.fromJson(Map<String, dynamic> json) => ProfesorModel(
        id: json["id"],
        correo: json["correo"],
        perfil: json["perfil"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "correo": correo,
        "perfil": perfil,
    };
}