import 'package:flower_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../cart/presentation/pages/cart_page.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  late final List<Widget> _pages;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      CartPage(onBackButton: () => _selectedIndex.value = 0),
      const ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) {
          return _pages[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex.value,
            onTap: (index) => _selectedIndex.value = index,
            type: BottomNavigationBarType.fixed,
          );
        },
      ),
    );
  }
}
