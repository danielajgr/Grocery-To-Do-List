class Ingredient {
  const Ingredient({required this.name, required this.amount});

  final String name;
  final double amount;

  
 double add_amount(double addition){
    return amount+addition;
 }

}