import 'package:flutter/material.dart';
import 'package:project/src/models/actividades_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';

class EvaluarPage extends StatelessWidget {

  final actividadProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  ActividadesModel actividad = new ActividadesModel();
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluar actividades '+materia.nombre),
      ),
      body: _crearLista(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: actividadProvider.cargarActividades(materia.id),
      builder: (BuildContext context, AsyncSnapshot<List<ActividadesModel >> snapshot){
        if(snapshot.hasData){
          final actividades = snapshot.data;
          return ListView.builder(
            itemCount: actividades.length,
            itemBuilder: (context, i)=>_crearItem(context, actividades[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context, ActividadesModel actividad){
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${actividad.nombre}'),
            subtitle: Text(actividad.id),
            onTap: (){
              _prefs.tempMat = materia.id;
              Navigator.pushNamed(context, 'evaluaralumno', arguments: actividad);
              print(_prefs.tempMat);
            },
          ),
        ],
      ),
    );
  }
}