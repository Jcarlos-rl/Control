import 'dart:convert';

NotificacionesModel notificacionesModelFromJson(String str) => NotificacionesModel.fromJson(json.decode(str));

String notificacionesModelToJson(NotificacionesModel data) => json.encode(data.toJson());

class NotificacionesModel {
  String id;
  String nombre;
  String mensaje;

  NotificacionesModel({
      this.id,
      this.nombre,
      this.mensaje,
  });

  factory NotificacionesModel.fromJson(Map<String, dynamic> json) => NotificacionesModel(
      id: json["id"],
      nombre: json["nombre"],
      mensaje: json["mensaje"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "nombre": nombre,
      "mensaje": mensaje,
  };
}