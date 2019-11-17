import 'dart:async';

class Validators {
  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email invalido');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError('La contraseña debe ser mayor a 6');
      }
    }
  );

  final validarClave = StreamTransformer<String,String>.fromHandlers(
    handleData: (clave, sink){
      if(clave == "654321"){
        sink.add(clave);
      }else{
        sink.addError('La clave no es correcta');
      }
    }
  );
}