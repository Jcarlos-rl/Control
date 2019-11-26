import 'package:flutter/material.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/providers/materia_provider.dart';

class ListaPage extends StatelessWidget {

  final alumnoProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  AmateriaModel alumno = new AmateriaModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;
    final date = new DateTime.now();
    //final dateNow = new DateFormat("dd-MM-yyyy").format(date);

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista '+date.toString()),
      ),
      body: _crearLista(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearLista(){
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red ),
      onDismissed: (direccion){
        alumnoProvider.borrarAlumno(materia.id,alumno.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('${alumno.matricula}'),
                subtitle: Text(alumno.id),
              onTap: (){
                alumnoProvider.crearAsistencia(alumno);
              },
            ),
          ],
        ),
      )
    );
  }
}