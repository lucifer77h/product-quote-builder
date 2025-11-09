import 'line_item.dart';

class QuoteModel {
  final String clientName;
  final String clientAddress;
  final String reference;
  final List<LineItem> lineItems;
  final String taxMode;
  final DateTime createdDate;

  QuoteModel({
    required this.clientName,
    required this.clientAddress,
    required this.reference,
    required this.lineItems,
    required this.taxMode,
    DateTime? createdDate,
  }) : createdDate = createdDate ?? DateTime.now();

  double calculateSubtotal() {
    double total = 0;
    for (var item in lineItems) {
      total += item.calculateSubtotal();
    }
    return total;
  }

  double calculateTotalTax() {
    double totalTax = 0;
    for (var item in lineItems) {
      totalTax += item.calculateTaxAmount();
    }
    return totalTax;
  }

  double calculateGrandTotal() {
    return calculateSubtotal() + calculateTotalTax();
  }
}