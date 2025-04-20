import 'package:flower_app/features/nav/presentation/cubit/nav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/cart/presentation/pages/cart_page.dart';
import 'package:flower_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:flower_app/features/profile/presentation/pages/profile_page.dart';

class NavbarPage extends StatefulWidget {
  final int initialTabIndex;
  final int selectedCategoryIndex;
  const NavbarPage({super.key, this.initialTabIndex = 0, this.selectedCategoryIndex = 0});

  static _NavbarPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_NavbarPageState>();
  }

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int currentTabIndex = 0;
  final Map<int, Widget> _cachedTabs = {};

  @override
  void initState() {
    super.initState();
    currentTabIndex = widget.initialTabIndex;
    _cachedTabs[currentTabIndex] = _buildTab(currentTabIndex);
  }

  Widget _buildTab(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return CategoriesScreen(
          selectedCategoryIndex: widget.selectedCategoryIndex,
          categories: context.read<NavCubit>().state.categories,
        );
      case 2:
        return CartPage(onBackButton: () => context.read<NavCubit>().changeTab(0));
      case 3:
        return const ProfilePage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavCubit, NavState>(
      listener: (context, state) {
        if (state.tabIndex != currentTabIndex) {
          if (!_cachedTabs.containsKey(state.tabIndex)) {
            _cachedTabs[state.tabIndex] = _buildTab(state.tabIndex);
          }
          setState(() {
            currentTabIndex = state.tabIndex;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: _cachedTabs.entries.map((entry) {
            // the offstage widget will hide the widget if the key is not equal to the currentTabIndex
            // removes the need to rebuild the widget
            // the widget will only be rebuilt when the key changes
            return Offstage(
              offstage: entry.key != currentTabIndex,
              child: entry.value,
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (index) {
            context.read<NavCubit>().changeTab(index);
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}