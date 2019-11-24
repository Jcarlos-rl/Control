import 'dart:convert';

CriteriosModel criteriosModelFromJson(String str) => CriteriosModel.fromJson(json.decode(str));

String criteriosModelToJson(CriteriosModel data) => json.encode(data.toJson());

class CriteriosModel {
  String id;
  String nombre;
  String porcentaje;
  String comentarios;
  String restricciones;

  CriteriosModel({
      this.id,
      this.nombre,
      this.porcentaje,
      this.comentarios,
      this.restricciones,
  });

  factory CriteriosModel.fromJson(Map<String, dynamic> json) => CriteriosModel(
      id: json["id"],
      nombre: json["nombre"],
      porcentaje: json["porcentaje"],
      comentarios: json["comentarios"],
      restricciones: json["restricciones"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "nombre": nombre,
      "porcentaje": porcentaje,
      "comentarios": comentarios,
      "restricciones": restricciones,
  };
}
