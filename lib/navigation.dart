import 'package:climaapp/TelaDados.dart';
import 'package:climaapp/main.dart';
import 'package:climaapp/history.dart';
import 'package:flutter/material.dart';
import 'package:climaapp/post.dart';

class NavApp extends StatefulWidget{
  const NavApp({super.key});

  @override
  State<NavApp> createState() => _NavAppState();
}

class _NavAppState extends State<NavApp> {
  int selectIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget> [
    TelaInicio(),
    TelaDados(),
    HistoricoClima(),
    PostClimaScreen(),
  ];

  void showItemTrap(int index){
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(selectIndex),
      ),

        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Monitoramento'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histórico'),
              BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
            ],
            currentIndex: selectIndex,
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: showItemTrap,
          ),
        ),
      ),
    );
  }
}