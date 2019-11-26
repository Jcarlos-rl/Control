import 'package:http/http.dart' as http;
import 'package:project/src/models/actividades_model.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/asistencia_model.dart';
import 'package:project/src/models/criterios_model.dart';
import 'package:project/src/models/foro_model.dart';
import 'dart:convert';
import 'package:project/src/models/materias_model.dart';

class MateriaProvider{
  final String _url = 'https://flutter-817d3.firebaseio.com';

  //--------------------Materia

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

    return materias;
  }

  Future<int> borrarMateria(String id) async{
    final url = '$_url/materias/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }

  //-------------------- Alumno

  Future<bool> crearAlumnoenMateria(AmateriaModel amateria,String id) async{
    final url = '$_url/materias/$id/alumnos.json';

    final resp = await http.post(url, body: amateriaModelToJson(amateria));

    final decodeData = json.decode(resp.body);

    final idMat = decodeData['name'];
    amateria.id = idMat;
    amateria.idmateria = id;
    crearAlumno(amateria);
    return true;
  }

  Future<bool> crearAlumno(AmateriaModel amateria) async{
    //amateria.id = idMat;
    final url = '$_url/alumnos.json';

    final resp = await http.post(url, body: amateriaModelToJson(amateria));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<int> borrarAlumno(String idMat, String id) async{
    final url = '$_url/materias/$idMat/alumnos/$id.json';
    final resp = await http.delete(url);

    buscar(id);

    print(json.decode(resp.body));
    return 1;
  }

  Future<Map<String, dynamic>> buscar(String id) async{
    final url = '$_url/alumnos.json?orderBy="id"&equalTo="$id"';
    final resp = await http.get(url);

    Map<String, dynamic> decodeData = json.decode(resp.body);

    final preid = decodeData.keys.toString();
    final id2 = preid.replaceAll("(", "").replaceAll(")", "");

    borrarAlumno2(id2);
  }

  Future<int> borrarAlumno2(String id) async{
    final url = '$_url/alumnos/$id.json';
    final resp = await http.delete(url);

    //print(url);

    print(json.decode(resp.body));
    return 1;
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

      //print(alumTemp.matricula);

      alumnos.add(alumTemp);
    });

    return alumnos;
  }

  //-------------------- Actividades

  Future<bool> crearActividad(ActividadesModel actividad,String idmat) async{

    final url = '$_url/materias/$idmat/actividades.json';

    final resp = await http.post(url, body: actividadesModelToJson(actividad));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> editarActividad(ActividadesModel actividad,String idMat) async{
    final url = '$_url/materias/$idMat/actividades/${ actividad.id }.json';

    final resp = await http.put(url, body: actividadesModelToJson(actividad));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<List<ActividadesModel>> cargarActividades(String id) async{
    final url = '$_url/materias/$id/actividades.json';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ActividadesModel> actividades = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final actTemp = ActividadesModel.fromJson(mat);
      actTemp.id = id;

      //print(alumTemp.matricula);

      actividades.add(actTemp);
    });

    return actividades;
  }

  Future<int> borrarActividad(String idMat, String id) async{
    final url = '$_url/materias/$idMat/actividades/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }

  Future<bool> crearCalificacionActividad(ActividadesModel actividad,String idmat, String id) async{

    final url = '$_url/materias/$idmat/alumnos/$id/actividades.json';

    final resp = await http.post(url, body: actividadesModelToJson(actividad));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  //-------------------- Criterios

  Future<bool> crearCriterio(CriteriosModel criterio,String idmat) async{

    final url = '$_url/materias/$idmat/criterios.json';

    final resp = await http.post(url, body: criteriosModelToJson(criterio));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> editarCriterio(CriteriosModel criterio,String idMat) async{
    final url = '$_url/materias/$idMat/criterios/${ criterio.id }.json';

    final resp = await http.put(url, body: criteriosModelToJson(criterio));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<List<CriteriosModel>> cargarCriterios(String id) async{
    final url = '$_url/materias/$id/criterios.json';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CriteriosModel> criterios = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final criTemp = CriteriosModel.fromJson(mat);
      criTemp.id = id;

      //print(alumTemp.matricula);

      criterios.add(criTemp);
    });

    return criterios;
  }

  Future<int> borrarCriterio(String idMat, String id) async{
    final url = '$_url/materias/$idMat/criterios/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }

  //-------------------- Lista

  Future<bool> crearAsistencia(AmateriaModel alumno) async{

    final date = new DateTime.now();
    final dateNow = new DateTime(date.year, date.month, date.day);
    print(dateNow);

    /*final url = '$_url/materias/$idmat/criterios.json';

    final resp = await http.post(url, body: criteriosModelToJson(criterio));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;*/
  }

  //--------------------Foro

  Future<bool> crearMensaje(ForoModel foro, String id) async{
    final url = '$_url/materias/$id/foro.json';

    final resp = await http.post(url, body: foroModelToJson(foro));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }

  Future<List<ForoModel>> cargarMensajes(String id) async{
    final url = '$_url/materias/$id/foro.json';
    final resp = await http.get(url);

    final  Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ForoModel> mensajes = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, mat){
      final menTemp = ForoModel.fromJson(mat);
      menTemp.id = id;

      //print(alumTemp.matricula);

      mensajes.add(menTemp);
    });

    return mensajes;
  }

 }