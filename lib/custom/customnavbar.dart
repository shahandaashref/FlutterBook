import 'package:flutter/material.dart';

class Customnavbar extends StatefulWidget {
  const Customnavbar({super.key});

  @override
  State<Customnavbar> createState() => _CustomnavbarState();
}

class _CustomnavbarState extends State<Customnavbar> {
  int currentPage = 0;
  @override
  void initState() {
    currentPage=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
        setState(() {
          currentPage = index;
        });
    switch (index) {
    case 0:
      Navigator.pushReplacementNamed(context, '/home');
      break;
    case 1:
      Navigator.pushReplacementNamed(context, '/saved');
      break;
    case 2:
      Navigator.pushReplacementNamed(context, '/search');
      break;
    case 3:
      Navigator.pushReplacementNamed(context, '/booksing');
      break;
  }
},
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.dashboard),
            icon: Icon(Icons.dashboard_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Badge(child: Icon(Icons.bookmark_outline)),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Badge(child: Icon(Icons.search_outlined)),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_basket),
            icon: Badge(child: Icon(Icons.shopping_basket_outlined)),
            label: '',
          ),
        ],
      );
  }
}