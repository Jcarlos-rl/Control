import 'package:flutter/material.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/models/notificaciones_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/notificaciones_provider.dart';

class NotificacionesPage extends StatelessWidget {

  final notificacionesProvider = new NotificacionesProvider();
  NotificacionesModel notificacion = new NotificacionesModel();
  final _prefs = new PreferenciasUsuario();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notificaciones"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.group)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _notificacionesGrupo(),
            _notificacionesAlumno(),
          ],
        ),
      ),
    );
  }

  //-----------------------------------Grupo

  Widget _notificacionesGrupo(){
    return Scaffold(
      body: _crearListaMaterias(),
    );
  }

  Widget _crearListaMaterias(){
    return FutureBuilder(
      future: notificacionesProvider.cargarMaterias(_prefs.id),
      builder: (BuildContext context, AsyncSnapshot<List<MateriasModel >> snapshot){
        if(snapshot.hasData){
          final materias = snapshot.data;
          return ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context, i)=>_crearItemMaterias(context, materias[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItemMaterias(BuildContext context,MateriasModel materia,){
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${materia.nombre}'),
            subtitle: Text(materia.id),
            onTap: (){
              _newNotificacion(context, materia);
            },
          ),
        ],
      )
    );
  }

  Future<void> _newNotificacion(BuildContext context, MateriasModel materia) async {
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
                  _guardarActividad(context, materia)
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

  Widget _guardarActividad(BuildContext context, MateriasModel materia){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context, materia);
      },
    );
  }

  void _submit(BuildContext context, MateriasModel materia)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    notificacionesProvider.crearNotificacionGrupo(notificacion, materia.id);

    Navigator.of(context).pop();
  }

  //-----------------------------------Alumno
  Widget _notificacionesAlumno(){
    return Scaffold(
      body: _crearListaAlumno(),
    );
  }

  Widget _crearListaAlumno(){
    return FutureBuilder(
      future: notificacionesProvider.cargarMaterias(_prefs.id),
      builder: (BuildContext context, AsyncSnapshot<List<MateriasModel >> snapshot){
        if(snapshot.hasData){
          final materias = snapshot.data;
          return ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context, i)=>_crearItemAlumno(context, materias[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItemAlumno(BuildContext context,MateriasModel materia){
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${materia.nombre}'),
            subtitle: Text(materia.id),
            onTap: ()=>Navigator.pushNamed(context, 'alumnonotificacion', arguments: materia),
          ),
        ],
      )
    );
  }
}