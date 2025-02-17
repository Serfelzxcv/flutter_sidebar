import 'package:dashboard_sidebar/sidebar.dart';
import 'package:dashboard_sidebar/sidebar_data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCollapsed = true;
  String? hoveredItem;
  bool isHovering = false;

  void toggleCollapse() {
    setState(() {
      isCollapsed = !isCollapsed;
      hoveredItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar con comunicación de hover
              ComponentSidebar(
                isCollapsed: isCollapsed,
                onToggle: toggleCollapse,
              ),

              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 172, 96, 96),
                  child: const Center(
                    child: Text("Contenido Principal"),
                  ),
                ),
              ),
            ],
          ),

          // Botón flotante con animación al expandir/colapsar el sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: isCollapsed ? 65 : 185,
            top: 20,
            child: GestureDetector(
              onTap: toggleCollapse,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 49, 49, 49),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(66, 0, 0, 0),
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child:
                isCollapsed ?
                 Icon(Icons.arrow_forward, color: Colors.white,size: 12,):
                 Icon(Icons.arrow_back, color: Colors.white,size: 12)
              ),
            ),
          ),

          // Subtareas flotantes con retraso para evitar desbordamiento
          if (isCollapsed && hoveredItem != null)
            Positioned(
              left: 75,
              top: 100,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(66, 54, 50, 50),
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: SidebarData.subItems[hoveredItem]!.map((subItem) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          subItem,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
