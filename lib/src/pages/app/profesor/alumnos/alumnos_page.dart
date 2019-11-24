import 'package:flutter/material.dart';
import 'package:project/src/models/amateria_model.dart';
import 'package:project/src/models/materias_model.dart';
import 'package:project/src/providers/materia_provider.dart';

class AlumnosPage extends StatelessWidget {

  final alumnoProvider = new MateriaProvider();
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
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(52, 54, 101, 1.0 ),
      onPressed:(){
        _newAlumno(context);
      } /*()=>Navigator.pushNamed(context, 'crearcurso')*/,
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
              //onTap: ()=>Navigator.pushNamed(context, 'accionescurso', arguments: materia),
            ),
          ],
        ),
      )
    );
  }


  Future<void> _newAlumno(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( 
          title: Text("Nuevo alumno"),
          content: Container(
            height: 165.0,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _crearMatricula(),
                  SizedBox(height: 30.0),
                  _guardarAlumno(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _crearMatricula(){
    return TextFormField(
      initialValue: alumno.matricula,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Color.fromRGBO(52, 54, 101, 1.0),
      decoration: InputDecoration(
        labelText: 'Matricula'
      ),
      onSaved: (value) => alumno.matricula = value,
      validator: (value){
        if (value.length<3) {
          return 'Ingrese la matricula del alumno';
        } else {
          return null;
        }
      }
    );
  }

  Widget _guardarAlumno(BuildContext context){
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

    alumnoProvider.crearAlumnoenMateria(alumno, materia.id);

    //Navigator.pop(context)
    Navigator.of(context).pop();
  }
}