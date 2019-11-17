import 'dart:convert';

AlumnoModel alumnoModelFromJson(String str) => AlumnoModel.fromJson(json.decode(str));

String alumnoModelToJson(AlumnoModel data) => json.encode(data.toJson());

class AlumnoModel {
    String id;
    String correo;
    bool perfil;

    AlumnoModel({
        this.id,
        this.correo,
        this.perfil = false,
    });

    factory AlumnoModel.fromJson(Map<String, dynamic> json) => AlumnoModel(
        id: json["id"],
        correo: json["correo"],
        perfil: json["perfil"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "correo": correo,
        "perfil": perfil,
    };
}