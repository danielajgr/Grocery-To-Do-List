class Ingredient {
  const Ingredient({required this.name, required this.amount, required this.units, required this.group});

  final String name;
  final double amount;
  final String units;
  final String group;
  
 double add_amount(double addition){
    return amount+addition;
 }

}