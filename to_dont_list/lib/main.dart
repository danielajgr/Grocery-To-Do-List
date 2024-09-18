// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/ingredient.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Ingredient> items = [const Ingredient(name: "Cereal", amount: 1, units: "Box(es)", group: "Other")];
  Map<String, List<Ingredient>> groupings = {}; 
  final _itemSet = <Ingredient>{};


  

  void _handleListChanged(Ingredient item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Ingredient item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, double amountText, String unitText, String groupText, TextEditingController textController1, TextEditingController textController2) {
    setState(() {
      print("Adding new item");
      Ingredient item =  Ingredient(name: itemText, amount: amountText, units: unitText, group: groupText);
      items.insert(0, item);
      textController1.clear();
      textController2.clear();

    });
  }

  @override
  Widget build(BuildContext context) {
    groupings = {};

    for (var ingred in items) {
    if (groupings.containsKey(ingred.group)) {
      groupings[ingred.group]!.add(ingred);
    } else {
      groupings[ingred.group] = [ingred];
    }
  }
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
        ),
        body:  ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: groupings.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.key, 
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: entry.value.map((item) {
                return ToDoListItem(
                  item: item,
                  completed: _itemSet.contains(item),
                  onListChanged: _handleListChanged,
                  onDeleteItem: _handleDeleteItem,
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: ToDoList(),
  ));
}
