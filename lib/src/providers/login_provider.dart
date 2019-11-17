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

    if(decodeData.isEmpty){
      final url = '$_url/usuario/alumno.json?orderBy="correo"&equalTo="$email"';
      final resp = await http.get(url);
      Map<String, dynamic> decodeDataAlumno = json.decode(resp.body);
      final String id = decodeDataAlumno.keys.toString();
      final String idnew = id.replaceAll("(", "").replaceAll(")", "");
      
      final urlid = '$_url/usuario/alumno/$idnew.json';
      final respid = await http.get(urlid); 
      Map<String, dynamic> decodePerfil = json.decode(respid.body);
      return{"usuario":"alumno","perfil":decodePerfil['perfil']}; 
    }else{
      final String id = decodeData.keys.toString();
      final String idnew = id.replaceAll("(", "").replaceAll(")", "");

      final urlid = '$_url/usuario/profesor/$idnew.json';
      final respid = await http.get(urlid); 
      Map<String, dynamic> decodePerfil = json.decode(respid.body);

      return{"usuario":"profesor","perfil":decodePerfil['perfil']};
    }
  }
}