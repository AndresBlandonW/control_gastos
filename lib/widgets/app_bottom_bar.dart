import 'package:control_gastos/common/funct.dart';
import 'package:control_gastos/screens/historial_pagos.dart';
import 'package:control_gastos/screens/main_screen.dart';
import 'package:control_gastos/screens/products_screen.dart';
import 'package:control_gastos/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../common/assets.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({Key? key}) : super(key: key);

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;
  List<Widget> pages = [MainScreen(), HistorialPagos(), ProductsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:
      ColoredBox(
        color: whiteBg,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: coral,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value  ;
              });

              if (value == 0) {
                checkMonthProducts();
              }
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.account_balance),
                ),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.history),
                ),
                label: 'Historial',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.payments),
                ),
                label: 'Productos',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.person),
                ),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
