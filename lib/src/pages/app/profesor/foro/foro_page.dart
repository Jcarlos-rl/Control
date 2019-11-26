import 'package:flutter/material.dart';
import 'package:project/src/models/foro_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';

class ForoPage extends StatelessWidget {

  final alumnoProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  ForoModel foro = new ForoModel();
  final _formKey = GlobalKey<FormState>();
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Foro '+materia.nombre),
      ),
      body: _crearLista(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.message),
      backgroundColor: Color.fromRGBO(52, 54, 101, 1.0 ),
      onPressed:(){
        _newMensaje(context);
      } /*()=>Navigator.pushNamed(context, 'crearcurso')*/,
    );
  }

  Widget _crearLista(){
    return FutureBuilder(
      future: alumnoProvider.cargarMensajes(materia.id),
      builder: (BuildContext context, AsyncSnapshot<List<ForoModel >> snapshot){
        if(snapshot.hasData){
          final mensajes = snapshot.data;
          return ListView.builder(
            itemCount: mensajes.length,
            itemBuilder: (context, i)=>_crearItem(context, mensajes[i]), 
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }

  Widget _crearItem(BuildContext context,ForoModel mensaje){
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('${_prefs.usuario}'),
            subtitle: Text(mensaje.hora),
            trailing: Text(mensaje.mensaje)
          ),
        ],
      ),
    );
  }


  Future<void> _newMensaje(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Nuevo mensaje"),
          content: Container(
            height: 165.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearMensaje(),
                  SizedBox(height: 30.0),
                  _guardarMensaje(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearMensaje(){
    return TextFormField(
      initialValue: foro.mensaje,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Mensaje'
      ),
      onSaved: (value) => foro.mensaje = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese tu mensaje';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarMensaje(BuildContext context){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context);
      },
    );
  }

  void _submit(BuildContext context)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    final date = DateTime.now();

    foro.usuario = _prefs.matricula;
    foro.tipo = _prefs.usuario;
    foro.hora = date.toString();

    alumnoProvider.crearMensaje(foro, materia.id);

    Navigator.of(context).pop();
  }
}