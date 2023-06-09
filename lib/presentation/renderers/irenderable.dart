import 'package:flutter/widgets.dart';

abstract class IRenderable<T> {
  final T model;

  IRenderable(this.model);

  Widget render(BuildContext context);
}
