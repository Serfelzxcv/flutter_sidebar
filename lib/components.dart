import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(title, style: const TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }
}
