// features/nav/nav_bar.dart
import 'package:flower_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});
  
  // creating Static instance to access the current state
  
  static _NavbarPageState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_NavbarPageState>();
    return state;
  }

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  late final List<Widget> _pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = const [
      HomeScreen(),
      CategoriesScreen(),
      Center(child: Text('Cart')),
      ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
  
  // Public method to change the tab 
  void changeTab(int index) {
    if (index >= 0 && index < _pages.length) {
      _selectedIndex.value = index;
    }
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
