import 'package:flutter/material.dart';
import 'package:dashboard_sidebar/sidebar_data.dart';

/// Constantes para una fácil modificación futura.
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
  String? hoveredItem;

  @override
  void didUpdateWidget(covariant ComponentSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isCollapsed) {
      // Esperar a que termine la animación de ancho antes de mostrar el texto.
      Future.delayed(kSidebarAnimationDuration, () {
        if (mounted && !widget.isCollapsed) {
          setState(() => showText = true);
        }
      });
    } else {
      setState(() => showText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kSidebarAnimationDuration,
      width: widget.isCollapsed ? kCollapsedWidth : kExpandedWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if (!widget.isCollapsed)
            Align(
              alignment: Alignment.centerRight,
              // Si tienes un botón o algún widget extra, puedes ponerlo aquí
            ),
          Expanded(
            child: Padding(
              // Ajusta el padding horizontal si deseas que sea menor/0 al colapsar
              padding: EdgeInsets.symmetric(
                horizontal:  kSidebarPadding,
              ),
              child: ListView(
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
                          color: isHovered
                              ? Colors.grey[300]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: kHorizontalPaddingPerItem,
                        ),
                        child: Row(
                          children: [
                            // AnimatedAlign para animar la posición del ícono al colapsar/expandir
                            AnimatedAlign(
                              duration: kSidebarAnimationDuration,
                              curve: Curves.easeInOut,
                              alignment: widget.isCollapsed
                                  ? Alignment.center
                                  : Alignment.centerLeft,
                              child: Icon(
                                _getIcon(title),
                                color: Colors.blue,
                              ),
                            ),
                            // Mostrar texto solo cuando hay espacio (showText = true)
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
