# flutter_honey_grid

A custom HoneyGridView with item in/out animation.

**Normal:**
![](https://raw.githubusercontent.com/yumi0629/PreImages/master/honey_grid.png)

**Animated:**
![](https://raw.githubusercontent.com/yumi0629/PreImages/master/animated_honey_grid_view.gif)

## Usage

#### Normal Usage
**Method I:** 
```
GridView.custom(
    gridDelegate: HoneySliverGridDelegate(crossAxisCount: 3),
    childrenDelegate: SliverChildListDelegate(
        // your item widget here.
);
```
**Method II:**
```
HoneyGridView.count(
    crossAxisCount: 3,
    // your item widget here.
    children: xxx ),
);
```

#### GridView with in/out Animation
**Notice:**  
The widget ```AnimatedHoneyGrid``` is designed like the Flutter's widget ```AnimatedList```, so the usage is the same. You'd better understand the usage of ```AnimatedList``` first.  

Please read the class ```AnimatedHoneyGridPage``` patiently.  
The base model class ```ListModel<E>``` is designed to deal with base insert/remove entries. 
The member ```listKey``` keeps a ```AnimatedHoneyGridState```, which creates a AnimatedHoneyGrid . 
You can use all public methods defined in ```AnimatedHoneyGridState``` , such as ```_state.insertItem()``` , which animated the item widget actually .
The member ```removedItemBuilder``` keeps a ```AnimatedGridRemovedItemBuilder``` , the widget will be displayed when the remove animation start.  

You can build in and out items like this:  
```
Widget _buildRemovedItem(String item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
    );
  }

Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
    );
  }
  
class CardItem extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onTap;
  final String item;

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
                onTap: (){},
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
```
Use a AnimatedBuilder or other transition widgets you like, which support transition , to bind the item widget with in/out animation .  
Now, you can use the methods in base list model , like ```insert()```/```removeAt()``` to add/remove element with Animation.  
If you want to do something cooler , you can custom a base list model like ListModel<E> , and insert/remove element by the way you like.  


