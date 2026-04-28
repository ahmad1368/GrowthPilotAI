import 'package:flutter/material.dart';
import 'omni_glass_container.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: OmniGlassContainer(
        borderRadius: 30,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: _buildItems(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildItems() => const [
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded), label: 'Insights'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded), label: 'Profile'),
      ];
}
