import 'dart:async';
import 'package:project/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class PerfilBloc with Validators {

  final _nombreController    = BehaviorSubject<String>();
  final _matriculaController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cpasswordController = BehaviorSubject<String>();
  final _areaController    = BehaviorSubject<String>();

  //Recuperar datos Stream
  Stream<String> get nombreStream     => _nombreController.stream.transform(validarNombre);
  Stream<String> get matriculaStream     => _matriculaController.stream.transform(validarNombre);
  Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);
  Stream<String> get cpasswordStream  => _cpasswordController.stream.transform(validarPassword);
  Stream<String> get areaStream     => _areaController.stream.transform(validarNombre);

  Stream<bool> get formValidStream =>
      Observable.combineLatest5(nombreStream, matriculaStream, passwordStream, cpasswordStream, areaStream, (n, m, p, cp, a) => true );

  //Insertar al Stream
  Function(String) get changeNombre   => _nombreController.sink.add;
  Function(String) get changeMatricula   => _matriculaController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCpassword => _cpasswordController.sink.add;
  Function(String) get changeArea    => _areaController.sink.add;


  //Obtener ultimo valor Stream
  String get nombre    => _nombreController.value;
  String get matricula    => _matriculaController.value;
  String get password => _passwordController.value;
  String get cpassword => _cpasswordController.value;
  String get area    => _areaController.value;

  dispose(){
    _nombreController?.close();
    _matriculaController?.close();
    _passwordController?.close();
    _cpasswordController?.close();
    _areaController?.close();
  }

  
}