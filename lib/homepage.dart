import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/quote_model.dart';
import 'models/line_item.dart';
import 'preview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Client Info Controllers
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _referenceController = TextEditingController();

  // Quote Data
  List<LineItem> lineItems = [LineItem()];
  String taxMode = 'inclusive'; // 'inclusive' or 'exclusive'

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _referenceController.dispose();
    for (var item in lineItems) {
      item.dispose();
    }
    super.dispose();
  }

  void _addLineItem() {
    setState(() {
      lineItems.add(LineItem());
    });
  }

  void _removeLineItem(int index) {
    if (lineItems.length > 1) {
      setState(() {
        lineItems[index].dispose();
        lineItems.removeAt(index);
      });
    }
  }

  double _calculateItemTotal(LineItem item) {
    double rate = double.tryParse(item.rateController.text) ?? 0;
    double quantity = double.tryParse(item.quantityController.text) ?? 0;
    double discount = double.tryParse(item.discountController.text) ?? 0;
    double tax = double.tryParse(item.taxController.text) ?? 0;

    double subtotal = (rate - discount) * quantity;
    double taxAmount = subtotal * (tax / 100);

    return subtotal + taxAmount;
  }

  double _calculateSubtotal() {
    double total = 0;
    for (var item in lineItems) {
      double rate = double.tryParse(item.rateController.text) ?? 0;
      double quantity = double.tryParse(item.quantityController.text) ?? 0;
      double discount = double.tryParse(item.discountController.text) ?? 0;

      total += (rate - discount) * quantity;
    }
    return total;
  }

  double _calculateTotalTax() {
    double totalTax = 0;
    for (var item in lineItems) {
      double rate = double.tryParse(item.rateController.text) ?? 0;
      double quantity = double.tryParse(item.quantityController.text) ?? 0;
      double discount = double.tryParse(item.discountController.text) ?? 0;
      double tax = double.tryParse(item.taxController.text) ?? 0;

      double subtotal = (rate - discount) * quantity;
      totalTax += subtotal * (tax / 100);
    }
    return totalTax;
  }

  double _calculateGrandTotal() {
    return _calculateSubtotal() + _calculateTotalTax();
  }

  void _previewQuote() {
    if (_formKey.currentState!.validate()) {
      QuoteModel quote = QuoteModel(
        clientName: _nameController.text,
        clientAddress: _addressController.text,
        reference: _referenceController.text,
        lineItems: lineItems,
        taxMode: taxMode,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(quote: quote),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Quote Builder'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClientInfoSection(),
              const SizedBox(height: 24),
              _buildLineItemsSection(),
              const SizedBox(height: 24),
              _buildTotalsSection(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Client Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Client Name *',
                hintText: 'Enter client name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter client name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address *',
                hintText: 'Enter address',
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _referenceController,
              decoration: const InputDecoration(
                labelText: 'Reference',
                hintText: 'Enter reference number (optional)',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: taxMode,
              decoration: const InputDecoration(
                labelText: 'Tax Mode',
              ),
              items: const [
                DropdownMenuItem(value: 'inclusive', child: Text('Tax Inclusive')),
                DropdownMenuItem(value: 'exclusive', child: Text('Tax Exclusive')),
              ],
              onChanged: (value) {
                setState(() {
                  taxMode = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineItemsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Line Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _addLineItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lineItems.length,
              itemBuilder: (context, index) {
                return _buildLineItem(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (lineItems.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeLineItem(index),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: lineItems[index].productController,
              decoration: const InputDecoration(
                labelText: 'Product/Service Name *',
                hintText: 'Enter product or service name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product/service name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: lineItems[index].quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity *',
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: lineItems[index].rateController,
                    decoration: const InputDecoration(
                      labelText: 'Rate *',
                      hintText: '0.00',
                      prefixText: '₹ ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: lineItems[index].discountController,
                    decoration: const InputDecoration(
                      labelText: 'Discount',
                      hintText: '0.00',
                      prefixText: '₹ ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: lineItems[index].taxController,
                    decoration: const InputDecoration(
                      labelText: 'Tax %',
                      hintText: '0',
                      suffixText: '%',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Item Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹ ${_calculateItemTotal(lineItems[index]).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quote Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            _buildTotalRow('Subtotal:', _calculateSubtotal()),
            const SizedBox(height: 8),
            _buildTotalRow('Total Tax:', _calculateTotalTax()),
            const Divider(height: 24),
            _buildTotalRow(
              'Grand Total:',
              _calculateGrandTotal(),
              isGrandTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isGrandTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isGrandTotal ? 18 : 16,
            fontWeight: isGrandTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          '₹ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isGrandTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isGrandTotal ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _previewQuote,
        icon: const Icon(Icons.visibility),
        label: const Text('Preview Quote'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}