import 'package:flutter/material.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';

class CursosPage extends StatelessWidget {

  final materiasProvider = new MateriaProvider();
  static final String routeName = 'home';
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis materias'),
      ),
      body: _crearLista(),
      floatingActionButton: _crearBoton(context),
    );
  } 

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(52, 54, 101, 1.0 ),
      onPressed: ()=>Navigator.pushNamed(context, 'crearcurso'),
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: materiasProvider.cargarMaterias(_prefs.id),
      builder: (BuildContext context, AsyncSnapshot<List<MateriasModel >> snapshot){
        if(snapshot.hasData){
          final materias = snapshot.data;
          return ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context, i)=>_crearItem(context, materias[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context,MateriasModel materia){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red ),
      onDismissed: (direccion){
        materiasProvider.borrarMateria(materia.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('${materia.nombre}'),
                subtitle: Text(materia.id),
              onTap: ()=>Navigator.pushNamed(context, 'accionescurso', arguments: materia),
            ),
          ],
        ),
      )
    );
  }
}