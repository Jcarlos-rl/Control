import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/src/models/profesor_model.dart';

class  ProfesorProvider {
  final String _url = "https://flutter-817d3.firebaseio.com";

  Future<bool> crearProfesor(ProfesorModel profesor) async{
    final url = '$_url/usuario/profesor.json';
    final resp = await http.post(url,body: profesorModelToJson(profesor));
    final decodeData = json.decode(resp.body);
    
    print(decodeData);
    return true;
  }

  Future<Map<String, dynamic>> editarProfesor(ProfesorModel profesor,String id) async{
    final url = '$_url/usuario/profesor/$id.json';
    final resp = await http.put(url, body: profesorModelToJson(profesor));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return {'ok':true, "mensaje":"Registro realizado con exito"};
  }
}