import 'package:flutter/material.dart';
import 'package:project/src/bloc/perfil_bloc.dart';
import 'package:project/src/bloc/provider.dart';
import 'package:project/src/models/alumno_model.dart';
import 'package:project/src/models/profesor_model.dart';
import 'package:project/src/pages/layout/fondo_app.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/alumno_provider.dart';
import 'package:project/src/providers/login_provider.dart';
import 'package:project/src/providers/profesor_provider.dart';
import 'package:project/src/utils/utils.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage>{
  final _prefs = new PreferenciasUsuario();
  final loginProvider = new LoginProvider();
  final alumnoProvider = new AlumnoProvider();
  final profesorProvider = new ProfesorProvider();
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

    final bloc = Provider.ofp(context);
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
                  Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,color: Color.fromRGBO(52, 54, 101, 1.0))),
                  SizedBox(height: 20.0),
                  _inputNombre(bloc),
                  SizedBox(height: 10.0),
                  _inputMatricula(bloc),
                  SizedBox(height: 10.0),
                  _inputPassword(bloc),
                  SizedBox(height: 10.0),
                  _inputCPassword(bloc),
                  SizedBox(height: 10.0),
                  _inputArea(bloc),
                  SizedBox(height: 30.0),
                  _btnLogin(bloc),
                ], 
              ),
            ),
          ),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _inputNombre( PerfilBloc bloc){
    return StreamBuilder(

      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.person, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'Ejemplo: Juan',
              labelText: 'Nombre',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeNombre,
          ),
        );
      }
    );
  }

  Widget _inputMatricula( PerfilBloc bloc){
    return StreamBuilder(

      stream: bloc.matriculaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.scatter_plot, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'Ejemplo: 201434285',
              labelText: 'Matricula',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeMatricula,
          ),
        );
      }
    );
  }

  Widget _inputArea( PerfilBloc bloc){
    return StreamBuilder(

      stream: bloc.areaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.school, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'Ejemplo: ITI',
              labelText: 'Area',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeArea,
          ),
        );
      }
    );
  }

  Widget _inputPassword( PerfilBloc bloc){
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
  
  Widget _inputCPassword( PerfilBloc bloc){
    return StreamBuilder(

      stream: bloc.cpasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Color.fromRGBO(52, 54, 101, 1.0)),
              hintText: 'Confirmar contraseña',
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeCpassword,
          ),
        );
      }
    );
  }

  Widget _btnLogin( PerfilBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Guardar'),
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

  _registro(PerfilBloc bloc, BuildContext context) async{
    if (bloc.password == bloc.cpassword) {

      Map reg = await loginProvider.editarPassword(_prefs.token, bloc.password);

      if(reg['ok']){
        if(_prefs.usuario == "profesor"){
          profesor.nombre = bloc.nombre;
          profesor.correo = _prefs.email;
          profesor.perfil = true;
          profesor.matricula = bloc.matricula;
          profesor.area = bloc.area;
          Map prof = await profesorProvider.editarProfesor(profesor, _prefs.id);
          if(prof['ok']){
            Navigator.pushReplacementNamed(context, 'nav');
            mostrarAlerta(context, "Bienvenido, tu registro se realizo con exito");
          }else{
            mostrarAlerta(context, "Algo salio mal, vuelve a intentar");
          }
        }else{
          alumno.nombre = bloc.nombre;
          alumno.correo = _prefs.email;
          alumno.perfil = true;
          alumno.matricula = bloc.matricula;
          alumno.area = bloc.area;
          Map alum = await alumnoProvider.editarAlumno(alumno, _prefs.id);
          if(alum['ok']){
            Navigator.pushReplacementNamed(context, 'nav');
            mostrarAlerta(context, "Bienvenido, tu registro se realizo con exito");
          }else{
            mostrarAlerta(context, "Algo salio mal, vuelve a intentar");
          }
        }   
      }else{
        mostrarAlerta(context, reg['mensaje']);
      }
    }else{
      mostrarAlerta(context, 'Las contraseñas no coinciden');
    }
  }
}