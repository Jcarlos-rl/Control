import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/src/models/actividades_model.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/providers/materia_provider.dart';

class EvaluarAlumnoPage extends StatelessWidget {

  final alumnoProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  AmateriaModel alumno = new AmateriaModel();
  ActividadesModel actividad = new ActividadesModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final matData = ModalRoute.of(context).settings.arguments;

    /*if(matData != null){
      materia = matData;
    }*/

    print(matData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluar actividad'),
      ),
      body: Container(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  /*Widget _crearLista(){
    return FutureBuilder(
      future: alumnoProvider.cargarAlumnos(materia.id),
      builder: (BuildContext context, AsyncSnapshot<List<AmateriaModel >> snapshot){
        if(snapshot.hasData){
          final alumnos = snapshot.data;
          return ListView.builder(
            itemCount: alumnos.length,
            itemBuilder: (context, i)=>_crearItem(context, alumnos[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context,AmateriaModel alumno){
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${alumno.matricula}'),
            subtitle: Text(alumno.id),
          ),
        ],
      ),
    );
  }*/

}