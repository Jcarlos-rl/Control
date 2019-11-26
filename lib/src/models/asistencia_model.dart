import 'dart:convert';

AsistenciaModel asistenciaModelFromJson(String str) => AsistenciaModel.fromJson(json.decode(str));

String asistenciaModelToJson(AsistenciaModel data) => json.encode(data.toJson());

class AsistenciaModel {
  String id;
  String fecha;

  AsistenciaModel({
      this.id,
      this.fecha,
  });

  factory AsistenciaModel.fromJson(Map<String, dynamic> json) => AsistenciaModel(
      id: json["id"],
      fecha: json["fecha"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "fecha": fecha,
  };
}