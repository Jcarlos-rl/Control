import 'package:http/http.dart' as http;
import 'package:project/src/models/amateria_model.dart';
import 'dart:convert';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/models/notificaciones_model.dart';

class NotificacionesProvider{
  
  final String _url = 'https://flutter-817d3.firebaseio.com';

  //--------------------Materia

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

  Future<bool> crearNotificacionGrupo(NotificacionesModel notificacion,String idmat) async{

    final url = '$_url/materias/$idmat/notificaciones.json';

    final resp = await http.post(url, body: notificacionesModelToJson(notificacion));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }



  //-------------------- Alumno

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

    return alumnos;
  }

  Future<bool> crearNotificacionAlumno(NotificacionesModel notificacion,String idmat,String id) async{

    final url = '$_url/materias/$idmat/alumnos/$id/notificaciones.json';

    final resp = await http.post(url, body: notificacionesModelToJson(notificacion));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


 }