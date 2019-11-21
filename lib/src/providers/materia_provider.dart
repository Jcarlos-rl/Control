import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';

class MateriaProvider{
  final String _url = 'https://flutter-817d3.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearMateria(MateriasModel materia) async{
    final url = '$_url/materias.json';

    final resp = await http.post(url, body: materiasModelToJson(materia));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<bool> editarMateria(MateriasModel materia) async{
    final url = '$_url/materias/${ materia.id }.json';

    final resp = await http.put(url, body: materiasModelToJson(materia));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
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

    //print(productos);

    return materias;
  }

  Future<int> borrarMateria(String id) async{
    final url = '$_url/materias/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;

  }
 }