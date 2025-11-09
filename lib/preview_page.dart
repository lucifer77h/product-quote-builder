import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/quote_model.dart';

class PreviewPage extends StatelessWidget {
  final QuoteModel quote;

  const PreviewPage({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              // Implement print functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Print functionality would go here')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share functionality would go here')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildClientInfo(),
                const SizedBox(height: 32),
                _buildLineItemsTable(),
                const SizedBox(height: 24),
                _buildTotals(),
                const SizedBox(height: 32),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QUOTATION',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Date: ${DateFormat('dd MMM yyyy').format(quote.createdDate)}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        if (quote.reference.isNotEmpty)
          Text(
            'Reference: ${quote.reference}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildClientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BILL TO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          quote.clientName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          quote.clientAddress,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildLineItemsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: const [
              Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              Expanded(flex: 2, child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              Expanded(flex: 2, child: Text('Discount', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              Expanded(flex: 1, child: Text('Tax%', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
            ],
          ),
        ),
        // Table Rows
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Column(
            children: [
              for (int i = 0; i < quote.lineItems.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    border: i < quote.lineItems.length - 1
                        ? Border(bottom: BorderSide(color: Colors.grey[200]!))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          quote.lineItems[i].productController.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          quote.lineItems[i].quantity.toStringAsFixed(0),
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹${quote.lineItems[i].rate.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹${quote.lineItems[i].discount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${quote.lineItems[i].taxPercent.toStringAsFixed(0)}%',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹${quote.lineItems[i].calculateTotal().toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotals() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildTotalRow('Subtotal:', quote.calculateSubtotal()),
                  const SizedBox(height: 8),
                  _buildTotalRow('Total Tax:', quote.calculateTotalTax()),
                  const Divider(height: 24),
                  _buildTotalRow(
                    'Grand Total:',
                    quote.calculateGrandTotal(),
                    isGrandTotal: true,
                  ),
                  if (quote.taxMode == 'inclusive')
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        '(Tax Inclusive)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isGrandTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isGrandTotal ? 18 : 14,
            fontWeight: isGrandTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isGrandTotal ? 20 : 14,
            fontWeight: FontWeight.bold,
            color: isGrandTotal ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Terms & Conditions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '• Payment is due within 30 days\n• Please include invoice number with payment\n• Thank you for your business!',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}