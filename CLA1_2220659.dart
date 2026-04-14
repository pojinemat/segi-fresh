import 'dart:io';

double calculateItemCost(String item, int quantity, Map<String, double> prices) {
  if (prices.containsKey(item)) {
    return prices[item]! * quantity;
  } else {
    print("Item '$item' does not exist.");
    return 0.0;
  }
}

// RECEIPT
String generateReceipt(
    String storeName,
    Map<String, int> purchasedItems,
    Map<String, double> prices,
    double subtotal,
    double discount,
    double tax,
    double total) {
  
  String receipt = """
Welcome to $storeName!
------------------------------
""";

// DETAILS OF PURCHASED ITEMS
  purchasedItems.forEach((item, quantity) {
    double cost = calculateItemCost(item, quantity, prices);
    receipt += "$item x $quantity = RM${cost.toStringAsFixed(2)}\n";
  });

  receipt += """------------------------------
Subtotal: RM${subtotal.toStringAsFixed(2)}
Discount: -RM${discount.toStringAsFixed(2)}
Tax (6%): RM${tax.toStringAsFixed(2)}
Total: RM${total.toStringAsFixed(2)}
------------------------------
Thank you for shopping at $storeName!
""";

  return receipt;
}

void main() {
  final String storeName = "Segi Fresh";
  const double taxRate = 0.06;
// ITEMS AND THEIR PRICES
  final Map<String, double> prices = {
    "Milk": 9.0,
    "Bread": 4.3,
    "Butter": 6.5,
    "Chocolate Milk": 11.0,
    "Yogurt": 9.0,
    "Cheese": 12.0,
    "Margerine": 7.0,
    "Eggs": 8.0,
    "Onion": 3.0,
    "Garlic": 2.5,
    "Ketchup": 6.5,
    "Mayonnaise": 10.0,
    "Mustard": 10.0,
    "Chilli Sauce": 8.0,
  };


  print("Welcome to $storeName!");
  print("------------------------------");

// STORE PURCAHSED ITEMS 
  Map<String, int> purchasedItems = {};

  for (String item in prices.keys) {
    stdout.write("$item x ");
    String? input = stdin.readLineSync();

    int quantity = int.tryParse(input ?? "0") ?? 0;
    purchasedItems[item] = quantity;
  }

  stdout.write("Coupon Code: ");
  String? couponCode = stdin.readLineSync();

  print("------------------------------");

  double subtotal = 0.0;
  purchasedItems.forEach((item, quantity) {
    subtotal += calculateItemCost(item, quantity, prices);
  });
  
//DISCOUNT RM5 IF COUPON CODE IS "SAVE5"
  double discount = 0.0;
  if (couponCode != null && couponCode == "SAVE5") {
    discount = 5.0;
  }

//CALCULATIONS OF TAX AND TOTAL
  double taxableAmount = subtotal - discount;
  double tax = taxableAmount * taxRate;

  double total = taxableAmount + tax;

  String receipt = generateReceipt(
      storeName,
      purchasedItems,
      prices,
      subtotal,
      discount,
      tax,
      total);

  print(receipt);
}
