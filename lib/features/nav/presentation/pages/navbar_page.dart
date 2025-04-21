// features/nav/presentation/pages/navbar_page.dart
import 'package:flower_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/event.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class NavbarPage extends StatefulWidget {
  final int initialTabIndex;
  const NavbarPage({super.key, this.initialTabIndex = 0});

  static _NavbarPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_NavbarPageState>();
  }

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  late final ValueNotifier<int> _selectedIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ValueNotifier(widget.initialTabIndex);
  }

  void changeTab(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex.value = index;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages =  [
      const HomeScreen(),
      const CategoriesScreen(),
      CartPage(onBackButton: () => _selectedIndex.value = 0),
      const ProfilePage(),
    ];
    final cartBloc = context.read<CartBloc>();
    if (cartBloc.state.getCartState == null) {
      cartBloc.add(const CartLoadEvent());
    }
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
            onTap: (index) => changeTab(index),
            type: BottomNavigationBarType.fixed,
          );
        },
      ),
    );
  }
}
