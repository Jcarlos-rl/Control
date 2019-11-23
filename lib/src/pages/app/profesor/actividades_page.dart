import 'package:flutter/material.dart';
import 'package:project/src/models/actividades_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/providers/materia_provider.dart';

class ActividadesPage extends StatelessWidget {

  final actividadProvider = new MateriaProvider();
  MateriasModel materia = new MateriasModel();
  ActividadesModel actividad = new ActividadesModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final MateriasModel matData = ModalRoute.of(context).settings.arguments;

    if(matData != null){
      materia = matData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades '+materia.nombre),
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
        _newActividad(context,actividad);
      } /*()=>Navigator.pushNamed(context, 'crearcurso')*/,
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

  Widget _crearItem(BuildContext context,ActividadesModel actividad){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red ),
      onDismissed: (direccion){
        actividadProvider.borrarActividad(materia.id,actividad.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('${actividad.nombre}'),
                subtitle: Text(actividad.id),
              onTap: (){
                _newActividad(context,actividad);
              },
            ),
          ],
        ),
      )
    );
  }


  Future<void> _newActividad(BuildContext context, ActividadesModel actividad) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Nueva Actividad"),
          content: Container(
            height: 350.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(actividad),
                  SizedBox(height: 10.0),
                  _crearDescripcion(actividad),
                  SizedBox(height: 10.0),
                  _crearFecha(actividad),
                  SizedBox(height: 30.0),
                  _guardarActividad(context, actividad)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearNombre(ActividadesModel actividad){
    return TextFormField(
      initialValue: actividad.nombre,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Nombre actividad'
      ),
      onSaved: (value) => actividad.nombre = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese el nombre de la actividad';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearDescripcion(ActividadesModel actividad){
    return TextFormField(
      initialValue: actividad.descripcion,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Descripción'
      ),
      onSaved: (value) => actividad.descripcion = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese la descripción de la actividad';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearFecha(ActividadesModel actividad){
    return TextFormField(
      initialValue: actividad.fechaentrega,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Fecha entrega'
      ),
      onSaved: (value) => actividad.fechaentrega = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese la fecha de entrega';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarActividad(BuildContext context, ActividadesModel actividad){
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(52, 54, 101, 1.0),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: (){
        _submit(context, actividad);
      },
    );
  }

  void _submit(BuildContext context, ActividadesModel actividad)async{

    if(!_formKey.currentState.validate()) return ;

    _formKey.currentState.save();

    if(actividad.id == null){
      actividadProvider.crearActividad(actividad, materia.id);
    }else{
      actividadProvider.editarActividad(actividad, materia.id);
    }

    //actividadProvider.editarActividad(actividad, materia.id);

    Navigator.of(context).pop();
  }
}