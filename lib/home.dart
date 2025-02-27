import 'package:flutter/material.dart';
import 'package:dashboard_sidebar/table/table.dart'; // tu nuevo DataTableWidget basado en data_table_2
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
  final List<String> columnTitles = [
    "Nombre",
    "Edad",
    "País",
    "Profesión",
    "Años Exp.",
    "Salario"
  ];

  /// Ejemplo de contenido: cada sublista es una fila.
  final List<List<dynamic>> tableData = [
    ["Alice", 25, "USA", "Desarrolladora", 3, "\$75,000"],
    ["Bob", 30, "Reino Unido", "Diseñador", 5, "£40,000"],
    ["Charlie", 35, "Canadá", "Analista", 7, "CAD 60,000"],
    ["Julia", 31, "Francia", "Gerente de Proy.", 4, "€50,000"],
    ["Ana", 29, "España", "QA Tester", 3, "€35,000"],
    ["Pedro", 40, "México", "Arquitecto de SW", 10, "\$90,000"],
        ["Alice", 25, "USA", "Desarrolladora", 3, "\$75,000"],
    ["Bob", 30, "Reino Unido", "Diseñador", 5, "£40,000"],
    ["Charlie", 35, "Canadá", "Analista", 7, "CAD 60,000"],
    ["Julia", 31, "Francia", "Gerente de Proy.", 4, "€50,000"],
    ["Ana", 29, "España", "QA Tester", 3, "€35,000"],
    ["Pedro", 40, "México", "Arquitecto de SW", 10, "\$90,000"],
        ["Alice", 25, "USA", "Desarrolladora", 3, "\$75,000"],
    ["Bob", 30, "Reino Unido", "Diseñador", 5, "£40,000"],
    ["Charlie", 35, "Canadá", "Analista", 7, "CAD 60,000"],
    ["Julia", 31, "Francia", "Gerente de Proy.", 4, "€50,000"],
    ["Ana", 29, "España", "QA Tester", 3, "€35,000"],
    ["Pedro", 40, "México", "Arquitecto de SW", 10, "\$90,000"],
        ["Alice", 25, "USA", "Desarrolladora", 3, "\$75,000"],
    ["Bob", 30, "Reino Unido", "Diseñador", 5, "£40,000"],
    ["Charlie", 35, "Canadá", "Analista", 7, "CAD 60,000"],
    ["Julia", 31, "Francia", "Gerente de Proy.", 4, "€50,000"],
    ["Ana", 29, "España", "QA Tester", 3, "€35,000"],
    ["Pedro", 40, "México", "Arquitecto de SW", 10, "\$90,000"],


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
              ComponentSidebar(
                isCollapsed: isCollapsed,
                onToggle: toggleCollapse,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // El contenedor que muestra la tabla
                    Container(
                      color: Colors.amber,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DataTableWidget(
                          columns: columnTitles,
                          rows: tableData,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
           flex: 4,
                child: Container(
                  color: const Color.fromARGB(255, 255, 144, 144),
                ),
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

          // Tooltip lateral cuando está colapsado (opcional)
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
