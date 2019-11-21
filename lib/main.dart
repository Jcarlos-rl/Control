import 'package:project/src/bloc/provider.dart';
import 'package:project/src/pages/app/profesor/acciones_curso_page.dart';
import 'package:project/src/pages/app/profesor/cursos_page.dart';
import 'package:project/src/pages/app/profesor/edit_curso_page.dart';
import 'package:project/src/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:project/src/pages/auth/perfil_page.dart';
import 'package:project/src/pages/auth/register_page.dart';
import 'package:project/src/pages/layout/nav_app.dart';
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
        initialRoute: 'nav',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'registro' : (BuildContext context) => RegistroPage(),
          'nav' : (BuildContext context) => BottomNavBar(),
          'perfil' : (BuildContext context) => PerfilPage(),
          'crearcurso' : (BuildContext context) => CrearCurso(),
          'accionescurso' : (BuildContext context) => AccionescursoPage(),
          'cursos' : (BuildContext context) => CursosPage(),      
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(52, 54, 101, 1.0)
        ),
      ),
    );
  }
}
