import 'package:flutter/material.dart';

/// Обёртка с вертикальной полосой прокрутки для всего экрана (view).
///
/// **Надо ли выносить в отдельный файл?**
/// Не обязательно: добавить `Scrollbar` + `SingleChildScrollView` в коде экрана можно и вручную.
/// Имеет смысл выносить, если:
/// - нужны единый вид и поведение полосы прокрутки на всех экранах;
/// - хотите переиспользовать одну обёртку (например, с отступами, клавиатурой, scroll-to-top);
/// - в нескольких экранах одна и та же разметка (заголовок, фильтры, таблица) и не хочется дублировать обёртку.
///
/// Подключайте: оберните содержимое экрана в [ViewScrollWrapper], когда нужна одна общая вертикальная прокрутка.
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
