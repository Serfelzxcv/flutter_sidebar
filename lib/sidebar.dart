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
    super.key,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ComponentSidebarState createState() => _ComponentSidebarState();
}

class _ComponentSidebarState extends State<ComponentSidebar> {
  bool showText = false;
  bool showSecondImage = false; // Controla la segunda imagen
  String? hoveredItem;

  @override
  void didUpdateWidget(covariant ComponentSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Control de texto para los ítems y para " PRINCIPAL"
    if (!widget.isCollapsed) {
      // Esperar la animación de ancho (300ms)
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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 12, 12),
              border: const Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255),
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: kSidebarPadding,
              right: kSidebarPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Imagen 1 (siempre visible)
                Image.asset(
                  'assets/images/image_1.png',
                  width: 40,
                  height: 40,
                ),
                // Segunda imagen (visible con showSecondImage = true)
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
          const Divider(
            height: 1, // Altura total del Divider
            thickness: 1, // Grosor de la línea
            color: Color.fromARGB(255, 0, 0, 0), // Color de la línea
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: kSidebarPadding,
              right: kSidebarPadding,
            ),
            child: Text(
              // Solo se concatena " PRINCIPAL" si el sidebar está expandido y showText es true.
              "MENU${(!widget.isCollapsed && showText) ? " PRINCIPAL" : ""}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const Divider(
            height: 1, // Altura total del Divider
            thickness: 1, // Grosor de la línea
            color: Colors.grey, // Color de la línea
          ),
          // Expanded para el resto del contenido (lista de items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSidebarPadding),
              child: ListView(

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
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: kHorizontalPaddingPerItem,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getIcon(title),
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
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

  /// Función auxiliar para asignar íconos según el título
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
