import 'package:flutter/material.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/models/notificaciones_model.dart';
import 'package:project/src/providers/notificaciones_provider.dart';

class NotificacionAlumnoPage extends StatelessWidget {

  final notificacionProvider = new NotificacionesProvider();
  NotificacionesModel notificacion = new NotificacionesModel();
  MateriasModel materia = new MateriasModel();
  AmateriaModel alumno = new AmateriaModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos '+materia.nombre),
      ),
      body: _crearLista(),
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: notificacionProvider.cargarAlumnos(materia.id),
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
              _newNotificacion(context, alumno);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _newNotificacion(BuildContext context, AmateriaModel alumno) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Nueva Notificación"),
          content: Container(
            height: 250.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(notificacion),
                  SizedBox(height: 10.0),
                  _crearDescripcion(notificacion),
                  SizedBox(height: 30.0),
                  _guardarActividad(context, alumno)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearNombre(NotificacionesModel notificacion){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Titulo notificación'
      ),
      onSaved: (value) => notificacion.nombre = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el titulo de la notificacion';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearDescripcion(NotificacionesModel notificacion){
    return TextFormField(
      //initialValue: actividad.descripcion,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Mensaje'
      ),
      onSaved: (value) => notificacion.mensaje = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el mensaje';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarActividad(BuildContext context, AmateriaModel alumno){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context, alumno);
      },
    );
  }

  void _submit(BuildContext context, AmateriaModel alumno)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    notificacionProvider.crearNotificacionAlumno(notificacion, materia.id, alumno.id);

    print(alumno.id);

    Navigator.of(context).pop();
  }
}