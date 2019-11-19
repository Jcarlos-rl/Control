import 'package:http/http.dart' as http;
import 'package:project/src/models/alumno_model.dart';
import 'dart:convert';

class  AlumnoProvider {
  final String _url = "https://flutter-817d3.firebaseio.com";

  Future<bool> crearAlumno(AlumnoModel alumno) async{
    final url = '$_url/usuario/alumno.json';
    final resp = await http.post(url,body: alumnoModelToJson(alumno));
    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<Map<String, dynamic>> editarAlumno(AlumnoModel alumno,String id) async{
    final url = '$_url/usuario/alumno/$id.json';
    final resp = await http.put(url, body: alumnoModelToJson(alumno));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return {'ok':true, "mensaje":"Registro realizado con exito"};
  }
}