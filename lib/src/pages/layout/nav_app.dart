import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/src/pages/app/home_page.dart';
import 'package:project/src/pages/app/profesor/cursos_page.dart';
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _pageindex=0;
  final HomePage _homePage = HomePage();
  final CursosPage _cursoPage = CursosPage();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return _homePage;
        break;
      case 1:
       return _cursoPage;
       break;
      /*case 2:
       return _buscarP;
       break;
      case 3:
       return _notificacionP;
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
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageindex,
        backgroundColor: Color.fromRGBO(255,255,255,1),
        items: <Widget>[
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.compare_arrows, size: 30, color: Colors.white),
        ],
        color: Color.fromRGBO(52, 54, 101, 1.0),
        buttonBackgroundColor: Color.fromRGBO(52, 54, 101, 1.0),
        onTap: (int tappedIndex){
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
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