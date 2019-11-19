// To parse this JSON data, do
//
//     final alumnoModel = alumnoModelFromJson(jsonString);

import 'dart:convert';

AlumnoModel alumnoModelFromJson(String str) => AlumnoModel.fromJson(json.decode(str));

String alumnoModelToJson(AlumnoModel data) => json.encode(data.toJson());

class AlumnoModel {
    String id;
    String correo;
    bool perfil;
    String nombre;
    String matricula;
    String area;

    AlumnoModel({
        this.id,
        this.correo,
        this.perfil = false,
        this.nombre,
        this.matricula,
        this.area,
    });

    factory AlumnoModel.fromJson(Map<String, dynamic> json) => AlumnoModel(
        id: json["id"],
        correo: json["correo"],
        perfil: json["perfil"],
        nombre: json["nombre"],
        matricula: json["matricula"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "correo": correo,
        "perfil": perfil,
        "nombre": nombre,
        "matricula": matricula,
        "area": area,
    };
}