import 'package:exmoor_underwear/presentation/pages/depo/add_product.dart';
import 'package:exmoor_underwear/presentation/pages/depo/status_list.dart';
import 'package:exmoor_underwear/presentation/pages/hesaplar/hesaplar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currenIndex = 0;

  final List<Widget> _pages = [
    AddProduct(),
    HesaplarPage(),
    StatusList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currenIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currenIndex,
          onTap: (index) {
            setState(() {
              currenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Ürün Ekle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Hesap Geçmişi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warehouse),
              label: 'Depo',
            ),
          ]),
    );
  }
}
