import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final int indexPage;
  MainPage({super.key, required this.indexPage,});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late int _selectedIndex = widget.indexPage;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        //New
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            activeIcon: Icon(Icons.home, color: Colors.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '',
            activeIcon: Icon(Icons.star, color: Colors.red),
          ),
        ],
      ),
    );
  }
}