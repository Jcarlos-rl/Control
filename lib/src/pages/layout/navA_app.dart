import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/src/pages/app/alumno/home_page.dart';
import 'package:project/src/pages/app/alumno/materias_alumno_page.dart';
import 'package:project/src/pages/app/profesor/home_page.dart';

class BottomNavBarA extends StatefulWidget {
  @override
  _BottomNavBarAState createState() => _BottomNavBarAState();
}

class _BottomNavBarAState extends State<BottomNavBarA> {

  int _pageindex=0;

  final HomePageA _homePageA = HomePageA();
  final MateriasAlumnoPage _cursoPageA = MateriasAlumnoPage();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return _homePageA;
        break;
      case 1:
       return _cursoPageA;
       break;
      /*case 2:
       return _notificacionesPage;
       break;
      case 3:
       return _cerrarSesion;
       break;
      case 4:
       return _cerrarP;
       break;*/
      default:
      return new Container(
        child: new Center(
          child: new Text(
            'Pagina no encontrada',
            style: new TextStyle(fontSize: 30)
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //int tappedIndex;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageindex,
        backgroundColor: Color.fromRGBO(255,255,255,1),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.book, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.power_settings_new, size: 30, color: Colors.white)
        ],
        color: Color.fromRGBO(52, 54, 101, 1.0),
        buttonBackgroundColor: Color.fromRGBO(52, 54, 101, 1.0),
        onTap: (tappedIndex){
          if (tappedIndex == 3) {
            Navigator.pushReplacementNamed(context, 'login');
          }else{
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          }
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}