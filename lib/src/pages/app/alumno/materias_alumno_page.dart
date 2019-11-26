import 'package:flutter/material.dart';
import 'package:project/src/providers/materia_alumno_provider.dart';

class MateriasAlumnoPage extends StatelessWidget {

  final alumnoMateriaProvider = new MateriaAlumnoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _newBottom(),
    );
  }

  Widget _newBottom(){
    return FloatingActionButton(
      onPressed: (){
        alumnoMateriaProvider.buscarMaterias();
      },
    );
  }
}