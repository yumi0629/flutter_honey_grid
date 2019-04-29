import 'package:flutter/material.dart';
import 'package:flutter_honey_grid/animated_honey_grid_view.dart';

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedHoneyGridState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedHoneyGridState get _state => listKey.currentState;

  void addAll(List<E> items) {
    _items.addAll(items);
    _state.addAll(items.length);
  }

  void insert(int index, E item) {
    _items.insert(index, item);
    _state.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _state.removeItem(index,
              (BuildContext context, Animation<double> animation) {
            return removedItemBuilder(removedItem, context, animation);
          });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
