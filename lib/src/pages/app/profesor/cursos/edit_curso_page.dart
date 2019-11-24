import 'package:flutter/material.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/preferencias/preferencias_user.dart';
import 'package:project/src/providers/materia_provider.dart';
import 'package:project/src/utils/utils.dart';

class CrearCurso extends StatefulWidget {

  @override
  _CrearCursoState createState() => _CrearCursoState();
}

class _CrearCursoState extends State<CrearCurso> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey =GlobalKey<ScaffoldState>();
  final materiaProvider = new MateriaProvider();
  final _prefs = new PreferenciasUsuario();

  MateriasModel materia = new MateriasModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        //title: Text('Materia'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Text('Información de la materia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,color: Color.fromRGBO(52, 54, 101, 1.0))),
                SizedBox(height: 30.0),
                _crearNombre(),
                SizedBox(height: 10.0,),
                _crearNRC(),
                SizedBox(height: 10.0,),
                _crearDias(),
                SizedBox(height: 10.0,),
                _crearHora(),
                SizedBox(height: 10.0,),
                _crearSalon(),
                SizedBox(height: 50.0,),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: materia.nombre,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Materia'
      ),
      onSaved: (value) => materia.nombre = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el nombre de la materia';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearNRC(){
    return TextFormField(
      initialValue: materia.nrc,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'NRC'
      ),
      onSaved: (value) => materia.nrc = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el NRC de la materia';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearDias(){
    return TextFormField(
      initialValue: materia.dias,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Dìas'
      ),
      onSaved: (value) => materia.dias = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese los dias de clase';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearHora(){
    return TextFormField(
      initialValue: materia.hora,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Hora'
      ),
      onSaved: (value) => materia.hora = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese horario de la clase';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearSalon(){
    return TextFormField(
      initialValue: materia.salon,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Salon'
      ),
      onSaved: (value) => materia.salon = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el salon de clase';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit()async{

    if(!formKey.currentState.validate()) return ;

    formKey.currentState.save();

    setState(() { _guardando = true;});
    if (materia.id == null) {
      materia.profesor = _prefs.id;
      materiaProvider.crearMateria(materia);
    }else{
      materiaProvider.editarMateria(materia);
    }
    setState(() {_guardando = false;});

    Navigator.pop(context);
    mostrarAlerta(context, "Registro Exitoso");
  }
}