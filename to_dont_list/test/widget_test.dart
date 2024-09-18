// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/ingredient.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: const Ingredient(name: "test", amount: 1, units: "Box(es)", group: "Other"),
                completed: true,
                onListChanged: (Ingredient item, bool completed) {},
                onDeleteItem: (Ingredient item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToDoListItem has a ClipRRect with amount and unit',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: const Ingredient(name: "test", amount: 1, units: "Box(es)", group: "Other"),
                completed: true,
                onListChanged: (Ingredient item, bool completed) {},
                onDeleteItem: (Ingredient item) {}))));
    final amountAndUnitFinder = find.text('1 Boxes(es)');

    ClipRRect circ = tester.firstWidget(amountAndUnitFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(amountAndUnitFinder, findsOneWidget);
    expect(ctext.data, "1 Boxes(es)");
  });

    testWidgets('Ingredients are grouped', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    await tester.enterText(find.byType(TextField).first, 'Apples');
    await tester.enterText(find.byType(TextField).at(1), '1');
    await tester.tap(find.byType(DropdownButton<String>).at(0));
    await tester.pump();
    await tester.tap(find.text('Produce').last);
    await tester.pump();

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    expect(find.text('Produce'), findsOneWidget);
    expect(find.text('Apples'), findsOneWidget);
    expect(find.text('1 CUP(s)'), findsOneWidget); 
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
