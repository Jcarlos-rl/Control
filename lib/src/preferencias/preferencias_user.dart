import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }


  //Get y Set de la ultima pagina
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value){
    _prefs.setString('token', value);
  }

  //Get y set del usuario
  get usuario{
    return _prefs.getString('usuario') ?? '';
  }
  set usuario(String value){
    _prefs.setString('usuario', value);
  }

  //Get y set del id
  get id{
    return _prefs.getString('id') ?? '';
  }
  set id(String value){
    _prefs.setString('id', value);
  }

  //Get y set del correo
  get email{
    return _prefs.getString('email') ?? '';
  }
  set email(String value){
    _prefs.setString('email', value);
  }


  //Get y set de la ultima pagina
  get ultimaPagina{
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value){
    _prefs.setString('ultimaPagina', value);
  }
}