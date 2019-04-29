import 'package:flutter/material.dart';
import 'package:flutter_honey_grid/animated_honey_grid_view.dart';
import 'package:flutter_honey_grid/base_model.dart';
import 'package:flutter_honey_grid/honey_grid_view.dart';

final List<String> images = [
  'images/food01.jpeg',
  'images/food03.jpeg',
  'images/food02.jpeg',
  'images/food04.jpeg',
  'images/food06.jpeg',
  'images/food05.jpeg',
  'images/food06.jpeg',
  'images/food05.jpeg',
  'images/food04.jpeg',
  'images/food03.jpeg',
  'images/food02.jpeg',
  'images/food01.jpeg',
  'images/food01.jpeg',
  'images/food03.jpeg',
  'images/food02.jpeg',
  'images/food05.jpeg',
  'images/food04.jpeg',
  'images/food06.jpeg',
  'images/food06.jpeg',
  'images/food05.jpeg',
];

class AnimatedHoneyGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimatedHoneyGridPageState();
}

class AnimatedHoneyGridPageState extends State<AnimatedHoneyGridPage> {
  final GlobalKey<AnimatedHoneyGridState> _listKey =
      GlobalKey<AnimatedHoneyGridState>();
  int _selectedItem;

  ListModel<String> _list;

  // Insert the "next item" into the list model.
  void _insert() {
    int index = _list.length;
    _list.insert(index, _list[1]);
    setState(() {});
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_selectedItem);
      setState(() {
        _selectedItem = null;
      });
    }
  }

  void _removeLast() {
    _list.removeAt(_list.length - 1);
    setState(() {
      _selectedItem = null;
    });
  }

  void _addAll() {
    _list.addAll(images.sublist(0, 3));
  }

  @override
  void initState() {
    super.initState();
    _list = ListModel<String>(
      listKey: _listKey,
      initialItems: [],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  Widget _buildRemovedItem(
      String item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: false,
      onTap: () {
        _selectedItem = index;
      },
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedHoneyGrid'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: _addAll,
            tooltip: 'insert a new item',
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _removeLast,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: AnimatedHoneyGrid(
        key: _listKey,
        crossAxisCount: 3,
        initialItemCount: _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final String item;
  final bool selected;

  Animation<Offset> get translation =>
      Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
          .animate(animation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AnimatedBuilder(
          animation: animation,
          builder: (_, __) {
            return FadeTransition(
              opacity: animation,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: ClipOval(
                  child: Image.asset(
                    item,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }),
    );
  }
}


class HoneyGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HoneyGridState();
}

class HoneyGridState extends State<HoneyGridPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoneyGrid'),
      ),
      body: _body2(),
    );
  }

  Widget _body() {
    return HoneyGridView.count(
      crossAxisCount: 3,
      children: images.map((path) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: ClipOval(
            child: Image.asset(
              path,
              fit: BoxFit.fill,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _body2() {
    return GridView.custom(
        gridDelegate: HoneySliverGridDelegate(crossAxisCount: 3),
        childrenDelegate: SliverChildListDelegate(images.map((path) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: ClipOval(
              child: Image.asset(
                path,
                fit: BoxFit.fill,
              ),
            ),
          );
        }).toList()));
  }
}
