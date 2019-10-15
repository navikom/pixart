import 'package:pixart/locator.dart';
import 'package:pixart/store/flow.dart';
import 'package:pixart/store/pictures/pictures.dart';

class AppFlow extends Flow {
  final Pictures pictures = locator<Pictures>();

  @override
  void start() {
    pictures.fetchItems();
  }

  @override
  void stop() {}

  @override
  String toString() {
    return '{"pictures": $pictures}';
  }
}
