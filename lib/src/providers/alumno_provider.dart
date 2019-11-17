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
}