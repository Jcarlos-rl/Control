import 'dart:async';
import 'package:project/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _claveController    = BehaviorSubject<String>();

  //Recuperar datos Stream
  Stream<String> get emailStream     => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);
  Stream<String> get claveStream     => _claveController.stream.transform(validarClave);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );

  //Insertar al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeClave    => _claveController.sink.add;


  //Obtener ultimo valor Stream
  String get email    => _emailController.value;
  String get password => _passwordController.value;
  String get clave    => _claveController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _claveController?.close();
  }

  
}