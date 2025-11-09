import 'package:flutter/material.dart';

class LineItem {
  final TextEditingController productController;
  final TextEditingController quantityController;
  final TextEditingController rateController;
  final TextEditingController discountController;
  final TextEditingController taxController;

  LineItem({
    String? product,
    String? quantity,
    String? rate,
    String? discount,
    String? tax,
  })  : productController = TextEditingController(text: product ?? ''),
        quantityController = TextEditingController(text: quantity ?? ''),
        rateController = TextEditingController(text: rate ?? ''),
        discountController = TextEditingController(text: discount ?? '0'),
        taxController = TextEditingController(text: tax ?? '0');

  void dispose() {
    productController.dispose();
    quantityController.dispose();
    rateController.dispose();
    discountController.dispose();
    taxController.dispose();
  }

  // Get values as doubles
  double get quantity => double.tryParse(quantityController.text) ?? 0;
  double get rate => double.tryParse(rateController.text) ?? 0;
  double get discount => double.tryParse(discountController.text) ?? 0;
  double get taxPercent => double.tryParse(taxController.text) ?? 0;

  // Calculate item total
  double calculateTotal() {
    double subtotal = (rate - discount) * quantity;
    double taxAmount = subtotal * (taxPercent / 100);
    return subtotal + taxAmount;
  }

  // Calculate subtotal without tax
  double calculateSubtotal() {
    return (rate - discount) * quantity;
  }

  // Calculate tax amount
  double calculateTaxAmount() {
    double subtotal = calculateSubtotal();
    return subtotal * (taxPercent / 100);
  }
}