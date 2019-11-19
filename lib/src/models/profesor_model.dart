import 'dart:convert';

ProfesorModel profesorModelFromJson(String str) => ProfesorModel.fromJson(json.decode(str));

String profesorModelToJson(ProfesorModel data) => json.encode(data.toJson());

class ProfesorModel {
    String id;
    String correo;
    bool perfil;
    String nombre;
    String matricula;
    String area;

    ProfesorModel({
        this.id,
        this.correo,
        this.perfil = false,
        this.nombre,
        this.matricula,
        this.area,
    });

    factory ProfesorModel.fromJson(Map<String, dynamic> json) => ProfesorModel(
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