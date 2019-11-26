import 'dart:convert';

ActividadesModel actividadesModelFromJson(String str) => ActividadesModel.fromJson(json.decode(str));

String actividadesModelToJson(ActividadesModel data) => json.encode(data.toJson());

class ActividadesModel {
  String id;
  String nombre;
  String descripcion;
  String fechaentrega;
  String calificacion;
  String observaciones;

  ActividadesModel({
      this.id,
      this.nombre,
      this.descripcion,
      this.fechaentrega,
      this.calificacion,
      this.observaciones,
  });

  factory ActividadesModel.fromJson(Map<String, dynamic> json) => ActividadesModel(
      id: json["id"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      fechaentrega: json["fechaentrega"],
      calificacion: json["calificacion"],
      observaciones: json["observaciones"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "fechaentrega": fechaentrega,
      "calificacion": calificacion,
      "observaciones": observaciones,
  };
}
