import 'package:flutter/material.dart';

/// Обёртка с вертикальной полосой прокрутки для экрана (view).
/// Даёт единый вид Scrollbar и вертикальный скролл. Оберните содержимое экрана в [ViewScrollWrapper],
/// когда нужна одна общая вертикальная прокрутка.
class ViewScrollWrapper extends StatefulWidget {
  final Widget child;

  const ViewScrollWrapper({super.key, required this.child});

  @override
  State<ViewScrollWrapper> createState() => _ViewScrollWrapperState();
}

class _ViewScrollWrapperState extends State<ViewScrollWrapper> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: widget.child,
      ),
    );
  }
}
