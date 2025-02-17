import 'package:flutter/material.dart';
import 'package:dashboard_sidebar/sidebar_data.dart';

class ComponentSidebar extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const ComponentSidebar({
    super.key,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  _ComponentSidebarState createState() => _ComponentSidebarState();
}

class _ComponentSidebarState extends State<ComponentSidebar> {
  bool showText = false; // Controla la visibilidad del texto

  @override
  void didUpdateWidget(covariant ComponentSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isCollapsed) {
      // Si se está expandiendo, esperamos 300ms antes de mostrar el texto
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!widget.isCollapsed) {
          setState(() {
            showText = true;
          });
        }
      });
    } else {
      // Si se está colapsando, ocultamos el texto inmediatamente
      setState(() {
        showText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isCollapsed ? 70 : 250,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            if (!widget.isCollapsed)
              Align(
                alignment: Alignment.centerRight,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding lateral
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: widget.isCollapsed ? 40.0 : 40.0, // Menos padding cuando está colapsado
                    ),
                    children: SidebarData.subItems.keys.map((title) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0), // Espaciado entre elementos
                        child: MouseRegion(
                          child: Row(
                            children: [
                              Icon(_getIcon(title), color: Colors.blue),
                              if (showText) // Mostramos el texto solo después del delay
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    title,
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
        
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String title) {
    switch (title) {
      case "All Inboxes":
        return Icons.inbox;
      case "Account":
        return Icons.account_circle;
      case "All Sent":
        return Icons.send;
      case "Scheduled":
        return Icons.schedule;
      default:
        return Icons.circle;
    }
  }
}
