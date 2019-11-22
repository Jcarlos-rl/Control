import 'package:http/http.dart' as http;
import 'package:project/src/models/amateria_model.dart';
import 'dart:convert';
import 'package:project/src/models/materias_model.dart';

class MateriaProvider{
  final String _url = 'https://flutter-817d3.firebaseio.com';

  Future<bool> crearMateria(MateriasModel materia) async{
    final url = '$_url/materias.json';

    final resp = await http.post(url, body: materiasModelToJson(materia));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<bool> crearAlumnoenMateria(AmateriaModel amateria,String id) async{
    final url = '$_url/materias/$id/alumnos.json';

    final resp = await http.post(url, body: amateriaModelToJson(amateria));

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

  Future<List<AmateriaModel>> cargarAlumnos(String id) async{
    final url = '$_url/materias/$id/alumnos.json';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<AmateriaModel> alumnos = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final alumTemp = AmateriaModel.fromJson(mat);
      alumTemp.id = id;

      alumnos.add(alumTemp);
    });

    //print(productos);

    return alumnos;
  }

  Future<int> borrarMateria(String id) async{
    final url = '$_url/materias/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }

  Future<int> borrarAlumno(String idMat, String id) async{
    final url = '$_url/materias/$idMat/alumnos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }

 }