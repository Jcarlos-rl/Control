import 'package:http/http.dart' as http;
import 'package:project/src/models/alumno_model.dart';
import 'package:project/src/models/profesor_model.dart';
import 'dart:convert';
import 'package:project/src/preferencias/preferencias_user.dart';

class LoginProvider{

  final String _firebaseToken = 'AIzaSyCpZJP_4IFv9sMRd2sBEnyXHy8T2VQCI4Q';
  final _prefs = new PreferenciasUsuario();
  final String _url = 'https://flutter-817d3.firebaseio.com';

  Future<Map<String,dynamic>> login(String email, String password) async{
    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp['idToken'];
      return {'ok':true,'token': decodeResp['idToken']};
    }else{
      return {'ok':false,'mensaje': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async{
    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp['idToken'];
      return {'ok':true,'token': decodeResp['idToken'],'mensaje':['Registro con exito']};
    }else{
      return {'ok':false,'mensaje': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> tipoUsuario (String email) async{
    final url = '$_url/usuario/profesor.json?orderBy="correo"&equalTo="$email"';
    final resp = await http.get(url);
    Map<String, dynamic> decodeData = json.decode(resp.body);

    if(decodeData.length==1){
      //print(decodeData);
      final preid = decodeData.keys.toString();
      final id = preid.replaceAll("(", "").replaceAll(")", "");
      return{"usuario":"profesor","id":id};
    }else{
      final url = '$_url/usuario/alumno.json?orderBy="correo"&equalTo="$email"';
      final resp = await http.get(url);
      Map<String, dynamic> decodeData = json.decode(resp.body);
      //print(decodeData);
      final preid = decodeData.keys.toString();
      final id = preid.replaceAll("(", "").replaceAll(")", "");
      return{"usuario":"alumno","id":id};
    }
  }

  Future<Map<String, dynamic>> perfil (String usuario, String id) async{
    final url = '$_url/usuario/$usuario/$id.json';
    final resp = await http.get(url);
    Map<String, dynamic> decodeData = json.decode(resp.body);

    return{"perfil":decodeData['perfil']};
  }
}