import 'dart:convert';

ForoModel foroModelFromJson(String str) => ForoModel.fromJson(json.decode(str));

String foroModelToJson(ForoModel data) => json.encode(data.toJson());

class ForoModel {
  String id;
  String usuario;
  String tipo;
  String mensaje;
  String hora;

  ForoModel({
      this.id,
      this.usuario,
      this.tipo,
      this.mensaje,
      this.hora,
  });

  factory ForoModel.fromJson(Map<String, dynamic> json) => ForoModel(
      id: json["id"],
      usuario: json["usuario"],
      tipo:  json["tipo"],
      mensaje: json["mensaje"],
      hora: json["hora"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "usuario": usuario,
      "tipo": tipo,
      "mensaje": mensaje,
      "hora": hora,
  };
}