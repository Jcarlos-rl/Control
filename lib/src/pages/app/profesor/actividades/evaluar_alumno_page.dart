import 'package:flutter/material.dart';
import 'package:project/src/models/actividades_model.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';

class EvaluarAlumnoPage extends StatelessWidget {

  final alumnoProvider = new MateriaProvider();
  AmateriaModel alumno = new AmateriaModel();
  ActividadesModel actividad = new ActividadesModel();
  final _formKey = GlobalKey<FormState>();
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final actData = ModalRoute.of(context).settings.arguments;

    if(actData != null){
      actividad = actData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluar alumnos'),
      ),
      body: _crearLista(),
      //floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: alumnoProvider.cargarAlumnos(_prefs.tempMat),
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
            onTap: (){
              _newCalificacion(context, actividad,alumno);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _newCalificacion(BuildContext context, ActividadesModel actividad, AmateriaModel alumno) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Asignar Calificación"),
          content: Container(
            height: 250.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearCalificacion(actividad),
                  SizedBox(height: 10.0),
                  _crearComentario(actividad),
                  SizedBox(height: 30.0),
                  _guardarActividad(context, actividad, alumno)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearCalificacion(ActividadesModel actividad){
    return TextFormField(
      initialValue: actividad.calificacion,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Calificación'
      ),
      onSaved: (value) => actividad.calificacion = value,
      validator: (value){
        if (value.length<0) {
          return 'Ingrese la calificación';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearComentario(ActividadesModel actividad){
    return TextFormField(
      initialValue: actividad.observaciones,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Observacion'
      ),
      onSaved: (value) => actividad.observaciones = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese la observación';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarActividad(BuildContext context, ActividadesModel actividad, AmateriaModel alumno){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context, actividad, alumno);
      },
    );
  }

  void _submit(BuildContext context, ActividadesModel actividad, AmateriaModel alumno)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    alumnoProvider.crearCalificacionActividad(actividad, _prefs.tempMat, alumno.id);
  }

}