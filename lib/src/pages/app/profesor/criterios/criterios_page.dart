import 'package:flutter/material.dart';
import 'package:project/src/models/criterios_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/providers/materia_provider.dart';

class CriteriosPage extends StatelessWidget {

  final criterioProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  CriteriosModel criterio = new CriteriosModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Criterios de evaluación '+materia.nombre),
      ),
      body: _crearLista(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(52, 54, 101, 1.0 ),
      onPressed:(){
        _newCriterio(context,criterio);
      } /*()=>Navigator.pushNamed(context, 'crearcurso')*/,
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: criterioProvider.cargarCriterios(materia.id),
      builder: (BuildContext context, AsyncSnapshot<List<CriteriosModel >> snapshot){
        if(snapshot.hasData){
          final criterios = snapshot.data;
          return ListView.builder(
            itemCount: criterios.length,
            itemBuilder: (context, i)=>_crearItem(context, criterios[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context,CriteriosModel criterio){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red ),
      onDismissed: (direccion){
        criterioProvider.borrarCriterio(materia.id,criterio.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('${criterio.nombre}'),
                subtitle: Text(criterio.id),
              onTap: (){
                _newCriterio(context,criterio);
              },
            ),
          ],
        ),
      )
    );
  }


  Future<void> _newCriterio(BuildContext context, CriteriosModel criterio) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Nuevo criterio"),
          content: Container(
            height: 450.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(criterio),
                  SizedBox(height: 10.0),
                  _crearPorcentaje(criterio),
                  SizedBox(height: 10.0),
                  _crearComentarios(criterio),
                  SizedBox(height: 10.0),
                  _crearRestricciones(criterio),
                  SizedBox(height: 30.0),
                  _guardarCriterio(context, criterio)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearNombre(CriteriosModel criterio){
    return TextFormField(
      initialValue: criterio.nombre,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Nombre del criterio'
      ),
      onSaved: (value) => criterio.nombre = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el nombre del criterio';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearPorcentaje(CriteriosModel criterio){
    return TextFormField(
      initialValue: criterio.porcentaje,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Procentaje'
      ),
      onSaved: (value) => criterio.porcentaje = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el procentaje del criterio';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearComentarios(CriteriosModel criterio){
    return TextFormField(
      initialValue: criterio.comentarios,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Comentario'
      ),
      onSaved: (value) => criterio.comentarios = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese los comentarios del criterio';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearRestricciones(CriteriosModel criterio){
    return TextFormField(
      initialValue: criterio.restricciones,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Restricciones'
      ),
      onSaved: (value) => criterio.restricciones = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese las restricciones del criterio';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarCriterio(BuildContext context, CriteriosModel criterio){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context, criterio);
      },
    );
  }

  void _submit(BuildContext context, CriteriosModel criterio)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    if(criterio.id == null){
      criterioProvider.crearCriterio(criterio, materia.id);
    }else{
      criterioProvider.editarCriterio(criterio, materia.id);
    }

    //actividadProvider.editarActividad(actividad, materia.id);

    //Navigator.of(context).pop();
  }
}