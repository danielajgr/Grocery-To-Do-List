class Ingredient {
  const Ingredient({required this.name, required this.amount, required this.units});

  final String name;
  final double amount;
  final String units;

  
 double add_amount(double addition){
    return amount+addition;
 }

}