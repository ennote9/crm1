import 'package:flutter/material.dart';

class ResponsiveScrollWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveScrollWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double minWidth = 1200.0;
        const double minHeight = 700.0;
        Widget content = child;
        if (constraints.maxHeight < minHeight) {
          // IMPORTANT: A vertical SingleChildScrollView gives its child an unbounded height.
          // If the page uses flex (e.g. Column with Expanded/Flexible), it will crash with:
          // "RenderFlex children have non-zero flex but incoming height constraints are unbounded".
          // Provide a finite height so flex layouts can resolve, and let the scroll view handle
          // the case when the viewport is smaller than this minimum.
          content = SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: minHeight,
              child: content,
            ),
          );
        }
        if (constraints.maxWidth < minWidth) {
          content = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: minWidth,
                maxWidth: minWidth,
              ),
              child: content,
            ),
          );
        }
        return content;
      },
    );
  }
}

class DialogScrollWrapper extends StatelessWidget {
  final Widget child;
  final double minWidth;
  const DialogScrollWrapper({
    super.key,
    required this.child,
    required this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double targetWidth = constraints.maxWidth < minWidth
            ? minWidth
            : constraints.maxWidth;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: targetWidth,
              maxWidth: targetWidth,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

// ============================================================================
// APP ENTRY POINT (SelectionArea added for global copy/paste)
// ============================================================================
