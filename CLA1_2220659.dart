import 'dart:io';

// Function to calculate cost of each item
double calculateItemCost(String item, int quantity, Map<String, double> prices) {
  if (prices.containsKey(item)) {
    return prices[item]! * quantity;
  } else {
    print("Item '$item' does not exist.");
    return 0.0;
  }
}

// Function to generate receipt
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

  // Item details
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
  // Immutable values
  final String storeName = "Segi Fresh";
  const double taxRate = 0.06;

  // Immutable price list
  final Map<String, double> prices = {
    "Apple": 2.5,
    "Milk": 5.0,
    "Bread": 3.0
  };

  /*
  Immutability is useful because:
  - It prevents accidental modification of important data like prices and tax rate.
  - Ensures consistency throughout the program.
  - Makes debugging easier since values do not change unexpectedly.
  */

  print("Welcome to $storeName!");
  print("------------------------------");

  // Store purchased items
  Map<String, int> purchasedItems = {};

  // Input quantities
  for (String item in prices.keys) {
    stdout.write("$item x ");
    String? input = stdin.readLineSync();

    int quantity = int.tryParse(input ?? "0") ?? 0;
    purchasedItems[item] = quantity;
  }

  // Coupon input (nullable)
  stdout.write("Coupon Code: ");
  String? couponCode = stdin.readLineSync();

  print("------------------------------");

  // Calculate subtotal
  double subtotal = 0.0;
  purchasedItems.forEach((item, quantity) {
    subtotal += calculateItemCost(item, quantity, prices);
  });

  // Apply discount
  double discount = 0.0;
  if (couponCode != null && couponCode == "SAVE5") {
    discount = 5.0;
  }

  // Calculate tax AFTER discount
  double taxableAmount = subtotal - discount;
  double tax = taxableAmount * taxRate;

  // Final total
  double total = taxableAmount + tax;

  // Generate and print receipt
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