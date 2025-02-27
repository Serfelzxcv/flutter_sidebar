import 'package:dashboard_sidebar/table/table.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_sidebar/sidebar.dart';
import 'package:dashboard_sidebar/sidebar_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCollapsed = true;
  String? hoveredItem;
  bool isHovering = false;

  /// Ejemplo de títulos de columna.
  final List<String> columnTitles = ["Nombre", "Edad", "País"];

  /// Ejemplo de contenido: cada sublista es una fila.
  final List<List<dynamic>> tableData = [
    ["Alice", 25, "USA"],
    ["Bob", 30, "Reino Unido"],
    ["Charlie", 35, "Canadá"],
    ["David", 40, "Australia"],
    ["Emma", 28, "Alemania"],
    ["Francisco", 33, "España"],
    ["Hana", 27, "Japón"],
    ["Igor", 29, "Rusia"],
    ["Julia", 31, "Francia"],
    ["Alice", 25, "USA"],
    ["Bob", 30, "Reino Unido"],
    ["Charlie", 35, "Canadá"],
    ["David", 40, "Australia"],
    ["Emma", 28, "Alemania"],
    ["Francisco", 33, "España"],
    ["Hana", 27, "Japón"],
    ["Igor", 29, "Rusia"],
    ["Julia", 31, "Francia"],
  ];

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
              // Sidebar, etc.
              ComponentSidebar(
                isCollapsed: isCollapsed,
                onToggle: toggleCollapse,
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DataTableWidget(
                      columns: columnTitles,
                      rows: tableData,
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 255, 144, 144),
                width: 700,
              ),
            ],
          ),




          // Botón animado para colapsar
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(66, 0, 0, 0),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: isCollapsed
                    ? const Icon(Icons.arrow_forward,
                        color: Color.fromARGB(255, 0, 0, 0), size: 12)
                    : const Icon(Icons.arrow_back,
                        color: Color.fromARGB(255, 0, 0, 0), size: 12),
              ),
            ),
          ),
          // Opcional: Tooltip lateral cuando está colapsado
          if (isCollapsed && hoveredItem != null)
            Positioned(
              left: 75,
              top: 100,
              child: Material(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(66, 54, 50, 50),
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: SidebarData.subItems[hoveredItem]!
                        .map(
                          (subItem) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              subItem,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
