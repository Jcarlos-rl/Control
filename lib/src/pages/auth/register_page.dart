import 'package:flutter/material.dart';
import 'package:project/src/bloc/login_bloc.dart';
import 'package:project/src/bloc/provider.dart';
import 'package:project/src/models/alumno_model.dart';
import 'package:project/src/models/profesor_model.dart';
import 'package:project/src/pages/layout/fondo_app.dart';
import 'package:project/src/providers/alumno_provider.dart';
import 'package:project/src/providers/login_provider.dart';
import 'package:project/src/providers/profesor_provider.dart';
import 'package:project/src/utils/utils.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage>{
  final loginProvider = new LoginProvider();
  final alumnoProvider = new AlumnoProvider();
  final profesorProvider = new ProfesorProvider();
  AlumnoModel alumno = new AlumnoModel();
  ProfesorModel profesor = new ProfesorModel();
  bool _profe = false;

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
              margin: EdgeInsets.only(top: 180.0),
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
                  Text('Registro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,color: Color.fromRGBO(52, 54, 101, 1.0))),
                  SizedBox(height: 30.0),
                  _inputEmail(bloc),
                  SizedBox(height: 20.0),
                  _inputPassword(bloc),
                  SizedBox(height: 10.0),
                  _esProfesor(),
                  _inputClave(bloc),
                  SizedBox(height: 30.0),
                  _btnLogin(bloc),
                ], 
              ),
            ),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            child: Text('¿Ya tienes una cuenta? Login',style: TextStyle(color: Colors.white)),
            onPressed: ()=> Navigator.pushNamed(context, 'login'),
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

  Widget _inputClave( LoginBloc bloc){
    return Visibility(
      visible: _profe,
      child: StreamBuilder(
        stream: bloc.claveStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),

            child: TextField(
              cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key, color: Color.fromRGBO(52, 54, 101, 1.0)),
                hintText: 'Clave de seguridad',
                //labelText: 'Clave',
                //counterText: snapshot.data,
                errorText: snapshot.error
              ),
              onChanged: bloc.changeClave,
            ),
          );
        }
      ),
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
            child: Text('Registrarse'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Color.fromRGBO(52, 54, 101, 1.0),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _registro(bloc,context):null,
        );
      }
    );
  }
  
  Widget _esProfesor(){
    return SwitchListTile(
      value: _profe,
      title: Text("Es profesor"),
      activeColor: Color.fromRGBO(52, 54, 101, 1.0),
      onChanged: (value)=>setState((){
        _profe=value;
      }),
    );
  }

  _registro(LoginBloc bloc, BuildContext context) async{
    if(_profe==true){
      if(bloc.clave=="654321"){
        Map info = await loginProvider.nuevoUsuario(bloc.email, bloc.password);

        if(info['ok']){
          profesor.correo=bloc.email;
          profesorProvider.crearProfesor(profesor);

          Navigator.pushReplacementNamed(context, 'login');
          mostrarAlerta(context, 'Registro realizado con exito');
        }else{
          mostrarAlerta(context, info['mensaje']);
        }
      }else{
        mostrarAlerta(context, 'Por favor ingrese la clave correcta');
      }
    }else{
      Map info = await loginProvider.nuevoUsuario(bloc.email, bloc.password);

      if(info['ok']){
        alumno.correo=bloc.email;
        alumnoProvider.crearAlumno(alumno);

        Navigator.pushReplacementNamed(context, 'login');
        mostrarAlerta(context, 'Registro realizado con exito');
      }else{
        mostrarAlerta(context, info['mensaje']);
      }
    }
  }
}