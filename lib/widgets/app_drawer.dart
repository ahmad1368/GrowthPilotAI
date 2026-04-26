import 'dart:ui';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent, // برای اینکه حالت شیشه‌ای دیده شود
      child: Stack(
        children: [
          // اثر شیشه‌ای کل منو
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Financial Profile',
                  onTap: () => _navigateTo(context, 'Profile Page'),
                ),
                _buildDrawerItem(
                  icon: Icons.security_outlined,
                  title: 'Security & Privacy',
                  onTap: () => _navigateTo(context, 'Security Page'),
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline_rounded,
                  title: 'Support Center',
                  onTap: () => _navigateTo(context, 'Support Page'),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Version 1.0.2', style: TextStyle(color: Colors.white24)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.cyanAccent,
            child: Icon(Icons.person, size: 40, color: Colors.black),
          ),
          SizedBox(height: 15),
          Text(
            'Ahmad',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Senior Developer',
            style: TextStyle(color: Colors.cyanAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
    );
  }

  void _navigateTo(BuildContext context, String pageName) {
    Navigator.pop(context); // بستن منو قبل از رفتن به صفحه بعد
    // در اینجا می‌توانید کد Navigator.push را برای صفحات واقعی بنویسید
    print('Navigating to $pageName'); 
  }
}