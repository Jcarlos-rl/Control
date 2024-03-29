import 'package:flutter/material.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';
import 'package:project/src/utils/utils.dart';

class AccionescursoPage extends StatefulWidget {

  @override
  _AccionescursoPageState createState() => _AccionescursoPageState();
}

class _AccionescursoPageState extends State<AccionescursoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey =GlobalKey<ScaffoldState>();
  final materiaProvider = new MateriaProvider();
  final _prefs = new PreferenciasUsuario();

  MateriasModel materia = new MateriasModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(materia.nombre),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: ()=>Navigator.pushNamed(context, 'crearcurso', arguments: materia),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              _botones(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _botones(BuildContext context){
    return Table(
      children: [
        TableRow(
          children: [
            GestureDetector(
              child: _crearBoton(Colors.white, Icons.person,'Alumnos'),
              onTap: (){
                Navigator.pushNamed(context, 'alumnos', arguments: materia);
              }
            ),
            GestureDetector(
              child: _crearBoton(Colors.white, Icons.list,'Actividades'),
              onTap: (){
                Navigator.pushNamed(context, 'actividades', arguments: materia);
              },
            ),
          ]
        ),
        TableRow(
          children: [
            GestureDetector(
              child: _crearBoton(Colors.white, Icons.edit,'Criterios'),
              onTap: (){
                Navigator.pushNamed(context, 'criterios', arguments: materia);
              },
            ), 
            GestureDetector( 
              child: _crearBoton(Colors.white, Icons.face,'Pase lista'),
              onTap: (){
                Navigator.pushNamed(context, 'lista', arguments: materia);
              },
            )
          ]
        ),
        TableRow(
          children: [
            GestureDetector(
              child: _crearBoton(Colors.white, Icons.featured_play_list,'Evaluar actividades'),
              onTap: (){
                Navigator.pushNamed(context, 'evaluar', arguments: materia);
              },
            ),
            GestureDetector(
              child: _crearBoton(Colors.white, Icons.featured_play_list,'Foro'),
              onTap: (){
                Navigator.pushNamed(context, 'foro', arguments: materia);
              },
            )
          ]
        ),
      ]
    );
  }

  Widget _crearBoton(Color color, IconData icono, String texto){
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(52, 54, 101, 1.0),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 5.0),
          CircleAvatar(
            backgroundColor: color,
            radius: 35.0,
            child: Icon(icono,color: Color.fromRGBO(52, 54, 101, 1.0), size:18.0),
          ),
          Text(texto, style: TextStyle(color: color)),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
  
}