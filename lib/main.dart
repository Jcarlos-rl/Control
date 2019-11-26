import 'package:project/src/bloc/provider.dart';
import 'package:project/src/pages/app/profesor/actividades/actividades_page.dart';
import 'package:project/src/pages/app/profesor/actividades/evaluar_actividad_page.dart';
import 'package:project/src/pages/app/profesor/actividades/evaluar_alumno_page.dart';
import 'package:project/src/pages/app/profesor/alumnos/alumnos_page.dart';
import 'package:project/src/pages/app/profesor/criterios/criterios_page.dart';
import 'package:project/src/pages/app/profesor/cursos/acciones_curso_page.dart';
import 'package:project/src/pages/app/profesor/cursos/cursos_page.dart';
import 'package:project/src/pages/app/profesor/cursos/edit_curso_page.dart';
import 'package:project/src/pages/app/profesor/foro/foro_page.dart';
import 'package:project/src/pages/app/profesor/lista/lista_page.dart';
import 'package:project/src/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:project/src/pages/auth/perfil_page.dart';
import 'package:project/src/pages/auth/register_page.dart';
import 'package:project/src/pages/layout/navA_app.dart';
import 'package:project/src/pages/layout/nav_app.dart';
import 'package:project/src/pages/notificaciones/alumnos_page.dart';
import 'package:project/src/pages/notificaciones/notificaciones.dart';
import 'package:project/src/preferencias/preferencias_user.dart';

void main() async{
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diseno',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'registro' : (BuildContext context) => RegistroPage(),
          'nav' : (BuildContext context) => BottomNavBar(),
          'navA' : (BuildContext context) => BottomNavBarA(),
          'perfil' : (BuildContext context) => PerfilPage(),
          'crearcurso' : (BuildContext context) => CrearCurso(),
          'accionescurso' : (BuildContext context) => AccionescursoPage(),
          'cursos' : (BuildContext context) => CursosPage(),
          'actividades' : (BuildContext context) => ActividadesPage(),
          'evaluar' : (BuildContext context) => EvaluarPage(),
          'evaluaralumno' : (BuildContext context) => EvaluarAlumnoPage(),
          'criterios' : (BuildContext context) => CriteriosPage(),
          'notificaciones' : (BuildContext context) => NotificacionesPage(),
          'lista' : (BuildContext context) => ListaPage(),
          'foro' : (BuildContext context) => ForoPage(),
          'alumnonotificacion' : (BuildContext context) => NotificacionAlumnoPage(),
          'alumnos' : (BuildContext context) => AlumnosPage()    
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(52, 54, 101, 1.0)
        ),
      ),
    );
  }
}
