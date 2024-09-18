import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/ingredient.dart';

typedef ToDoListChangedCallback = Function(Ingredient item, bool completed);
typedef ToDoListRemovedCallback = Function(Ingredient item);

class ToDoListItem extends StatelessWidget {
  ToDoListItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Ingredient item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(item);
            }
          : null,
      leading: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child: Container(
          width: 70, // Adjust the width as needed
          height: 40, // Adjust the height as needed
          color: Colors.blue,
          child: Center( // Center the text inside the square
            child: Text(
              ('${item.amount} ${item.units}'),
              style: _getTextStyle(context), // Optional: make text more visible
            ),
          ),
        ),
)
,
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
