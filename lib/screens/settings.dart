import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;
  SettingsScreen({required this.onThemeToggle, required this.themeMode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Restaurant Details'),
              subtitle: Text('Name, logo, address'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.percent),
              title: Text('Default Tax & Discount'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.currency_exchange),
              title: Text('Currency'),
              onTap: () {},
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: themeMode == ThemeMode.dark,
              onChanged: (val) => onThemeToggle(),
              secondary: Icon(Icons.brightness_6),
            ),
          ],
        ),
      ),
    );
  }
}
