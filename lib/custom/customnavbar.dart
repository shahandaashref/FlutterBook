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
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (int index) {
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
          // case 3:
          //   Navigator.pushReplacementNamed(context, '/booksing');
          //   break;
        }
      },
      type: BottomNavigationBarType.fixed, // عشان يظهر كل الأيقونات حتى لو أكتر من 3
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          activeIcon: Icon(Icons.bookmark),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: '',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.shopping_basket_outlined),
        //   activeIcon: Icon(Icons.shopping_basket),
        //   label: '',
        // ),
      ],
    );
  }
}
