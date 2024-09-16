import 'package:flutter/material.dart';

List<String> measurements = ["TBSP(s)", "TSP(s)", "CUP(s)", "BOX(es)", "CAN(s)"];

typedef ToDoListAddedCallback = Function(String name, double quantity, String unit, TextEditingController textController1, TextEditingController textController2);


class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  final TextEditingController _inputController1 = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText1 = "";
  String valueText2 = "";
  String initUnit = measurements.first;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText1 = value;
              });
            },
            controller: _inputController1,
            decoration: const InputDecoration(hintText: "Type something here"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      valueText2 = value;
                    });
                  },
                  controller: _inputController2,
                  decoration: const InputDecoration(hintText: "Measurement"),
                ),
              ),
              DropdownButton<String>(
                value: initUnit,
                onChanged: (String? unit) {
                  setState(() {
                    initUnit = unit!;
                  });
                },
                items: measurements.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          onPressed: valueText1.isNotEmpty && valueText2.isNotEmpty
              ? () {
                  widget.onListAdded(valueText1, double.parse(valueText2), initUnit, _inputController1,_inputController2);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('OK'),
        ),
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
