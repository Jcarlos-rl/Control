import 'package:flutter/material.dart';
import 'package:project/src/bloc/login_bloc.dart';
import 'package:project/src/bloc/provider.dart';
import 'package:project/src/models/alumno_model.dart';
import 'package:project/src/models/profesor_model.dart';
import 'package:project/src/pages/layout/fondo_app.dart';
import 'package:project/src/providers/login_provider.dart';
import 'package:project/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override 
  _LoginPageState createState()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginProvider = new LoginProvider();
  AlumnoModel alumno = new AlumnoModel();
  ProfesorModel profesor = new ProfesorModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoApp(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0, width: double.infinity),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 210.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              width: size.width*0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0)
                  )
                ],
                color: Colors.white 
              ),
              child: Column(
                children: <Widget>[
                  Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,color: Color.fromRGBO(52, 54, 101, 1.0))),
                  SizedBox(height: 30.0),
                  _inputEmail(bloc),
                  SizedBox(height: 20.0),
                  _inputPassword(bloc),
                  SizedBox(height: 30.0),
                  _btnLogin(bloc)
                ], 
              ),
            ),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            child: Text('Crear cuenta',style: TextStyle(color: Colors.white)),
            onPressed: ()=> Navigator.pushNamed(context, 'registro'),
          ),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _inputEmail( LoginBloc bloc){
    return StreamBuilder(

      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'correo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      }
    );
  }

  Widget _inputPassword( LoginBloc bloc){
    return StreamBuilder(

      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'Contraseña',
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      }
    );
  }

  Widget _btnLogin( LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Color.fromRGBO(52, 54, 101, 1.0),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(bloc,context):null,
        );
      }
    );
  }

  _login(LoginBloc bloc, BuildContext context) async{

    //print("sdfghjkj");
    Map info = await loginProvider.login(bloc.email, bloc.password);

    if(info['ok']){
      Map user = await loginProvider.tipoUsuario(bloc.email);

      Map perfil = await loginProvider.perfil(user['usuario'], user['id']);

      if(perfil['perfil']==false){
        Navigator.pushReplacementNamed(context, 'perfil');
      }else{
        Navigator.pushReplacementNamed(context, 'nav');
      }
    }else{
      mostrarAlerta(context, info['mensaje']);
    }
  }
}