import 'package:http/http.dart' as http;
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'dart:convert';
import 'package:project/src/preferencias/preferencias_user.dart';

class MateriaAlumnoProvider {
  final String _url = 'https://flutter-817d3.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<List<AmateriaModel>> buscarMaterias() async{
    final url = '$_url/alumnos.json?orderBy="matricula"&equalTo="201434287"';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<AmateriaModel> materias = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final matTemp = AmateriaModel.fromJson(mat);
      matTemp.id = id;

      materias.add(matTemp);
      print(materias);
    });

    //print(materias);
  }

  Future<List<MateriasModel>> cargarMaterias(String id) async{
    final url = '$_url/materias.json?orderBy="profesor"&equalTo="$id"';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<MateriasModel> materias = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final matTemp = MateriasModel.fromJson(mat);
      matTemp.id = id;

      materias.add(matTemp);
    });

    return materias;
  }
}