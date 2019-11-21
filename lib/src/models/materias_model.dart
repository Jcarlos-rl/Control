import 'dart:convert';

MateriasModel materiasModelFromJson(String str) => MateriasModel.fromJson(json.decode(str));

String materiasModelToJson(MateriasModel data) => json.encode(data.toJson());

class MateriasModel {
  String id;
  String nombre;
  String nrc;
  String profesor;
  String dias;
  String hora;
  String salon;

  MateriasModel({
    this.id,
    this.nombre,
    this.nrc,
    this.profesor,
    this.dias,
    this.hora,
    this.salon,
  });

  factory MateriasModel.fromJson(Map<String, dynamic> json) => MateriasModel(
    id: json["id"],
    nombre: json["nombre"],
    nrc: json["nrc"],
    profesor: json["profesor"],
    dias: json["dias"],
    hora: json["hora"],
    salon: json["salon"],
  );

  Map<String, dynamic> toJson() => {
    //"id": id,
    "nombre": nombre,
    "nrc": nrc,
    "profesor": profesor,
    "dias": dias,
    "hora": hora,
    "salon": salon,
  };
}
