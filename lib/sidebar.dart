import 'package:flutter/material.dart';
import 'package:dashboard_sidebar/sidebar_data.dart';

/// Constantes para una fácil modificación.
const double kCollapsedWidth = 76;
const double kExpandedWidth = 200;
const double kVerticalPaddingPerItem = 5.0;
const double kHorizontalPaddingPerItem = 8.0;
const double kSidebarPadding = 17.0;
const double kTopListPadding = 40.0;

/// Duraciones de animación.
const Duration kSidebarAnimationDuration = Duration(milliseconds: 300);
const Duration kHoverAnimationDuration = Duration(milliseconds: 200);

class ComponentSidebar extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const ComponentSidebar({
    Key? key,
    required this.isCollapsed,
    required this.onToggle,
  }) : super(key: key);

  @override
  _ComponentSidebarState createState() => _ComponentSidebarState();
}

class _ComponentSidebarState extends State<ComponentSidebar> {
  bool showText = false;
  bool showSecondImage = false; // Controla la segunda imagen
  String? hoveredItem;

  @override
  void didUpdateWidget(covariant ComponentSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Control de texto (como ya lo manejabas)
    if (!widget.isCollapsed) {
      // Esperar la animación de ancho
      Future.delayed(kSidebarAnimationDuration, () {
        if (mounted && !widget.isCollapsed) {
          setState(() => showText = true);
        }
      });
    } else {
      setState(() => showText = false);
    }

    // Control de segunda imagen
    if (!widget.isCollapsed) {
      // Retrasa un poco su aparición para evitar overflow
      Future.delayed(kSidebarAnimationDuration, () {
        if (mounted && !widget.isCollapsed) {
          setState(() => showSecondImage = true);
        }
      });
    } else {
      setState(() => showSecondImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kSidebarAnimationDuration,
      width: widget.isCollapsed ? kCollapsedWidth : kExpandedWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),


      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSidebarPadding),
            child: Container(

              child: Row(
                // Mantenemos siempre a la izquierda:
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Imagen 1 (se muestra siempre)
                  Image.asset(
                    'assets/images/image_1.png',
                    width: 40,
                    height: 40,
                  ),
              
                  // Segunda imagen con delay (sólo aparece cuando showSecondImage = true)
                  if (showSecondImage) ...[
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/images/image_2.png',
                      width: 80,
                      height: 40,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Expanded para el resto del contenido (lista de items, etc.)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSidebarPadding),
              child: ListView(
                // Espacio superior antes de la lista
                padding: const EdgeInsets.only(top: kTopListPadding),
                children: SidebarData.subItems.keys.map((title) {
                  final bool isHovered = hoveredItem == title;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kVerticalPaddingPerItem,
                    ),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => hoveredItem = title),
                      onExit: (_) => setState(() => hoveredItem = null),
                      child: AnimatedContainer(
                        duration: kHoverAnimationDuration,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isHovered ? Colors.grey[300] : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: kHorizontalPaddingPerItem,
                        ),
                        child: Row(
                          children: [
                            // Ícono
                            Icon(
                              _getIcon(title),
                              color: Colors.blue,
                            ),
                            // Texto (aparece cuando showText = true)
                            if (showText)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Función auxiliar para asignar íconos según título
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
