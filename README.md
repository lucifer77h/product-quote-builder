#  Product Quote Builder - Flutter App

A Flutter-based mobile application for creating professional product quotations. This app allows users to generate quotes with multiple line items, automatic calculations, and a clean preview interface.

##  Project Overview

This project was developed as part of an internship assessment. The app helps businesses create professional quotations by managing client information, line items, and generating printable quotes.

##  Features

- **Client Management**: Add client details including name, address, and reference number
- **Dynamic Line Items**: Add or remove products/services dynamically
- **Real-time Calculations**: Automatic calculation of totals as you type
- **Tax Management**: Support for tax-inclusive and tax-exclusive modes
- **Professional Preview**: Clean, printable quote layout
- **Responsive Design**: Works smoothly on different screen sizes

##  Requirements Implemented

### 1. Quote Form UI
-  Client information input (name, address, reference)
-  Line items with product/service details
-  Quantity, Rate, Discount, and Tax percentage fields
-  Add/Remove line items functionality

### 2. Auto Calculations
-  Per item total: (rate - discount) × quantity + tax
-  Quote subtotal (sum of all items before tax)
- Total tax calculation
-  Grand total

### 3. Responsive Layout
-  Adapts to different screen sizes
-  Organized spacing and alignment
-  Professional UI design

### 4. Preview Section
-  Clean, printable quote layout
-  Professional formatting
-  All details displayed clearly

### 5. Bonus Features
-  Tax mode dropdown (inclusive/exclusive)
-  Currency formatting with Rupee symbol
-  Form validation
-  Professional color scheme

##  Tech Stack

- **Framework**: Flutter 3.35.2
- **Language**: Dart
- **State Management**: setState (for this scope)
- **UI**: Material Design

##  Project Structure

```
lib/
├── main.dart                 # App entry point
├── homepage.dart            # Main  page of the app
├── preview_page.dart        # Quote preview page
└── models/
    ├── line_item.dart       # Line item model
    └── quote_model.dart     # Quote model
```

##  Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio / VS Code with Flutter extensions
- An Android/iOS emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd product-quote-builder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

##  Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.18.0  # For date formatting
```

##  How to Use

1. **Launch the app** and you'll see the quote form
2. **Fill in client details** at the top
3. **Add line items** by clicking the "Add Item" button
4. **Enter product details** for each item:
    - Product/Service name
    - Quantity
    - Rate per unit
    - Discount (optional)
    - Tax percentage
5. **View real-time calculations** as you type
6. **Click "Preview Quote"** to see the final formatted quote
7. **Use Print/Share buttons** (to be implemented) in the preview

##  Features Breakdown

### Home Page
- **Client Info Section**: Card-based layout for client details
- **Line Items Section**: Dynamic list of products/services
- **Totals Section**: Real-time calculation display
- **Validation**: All required fields are validated

### Preview Page
- **Professional Header**: Quote title, date, and reference
- **Client Information**: Formatted client details
- **Items Table**: Clean table layout with all line items
- **Totals Summary**: Subtotal, tax, and grand total
- **Footer**: Terms and conditions section

## Code Structure

### Models

**LineItem** - Manages individual product/service data

- productController: Product name
- quantityController: Quantity
- rateController: Rate per unit
- discountController: Discount amount
- taxController: Tax percentage


**QuoteModel** - Manages complete quote data

- clientName, clientAddress, reference
- List of LineItems
- taxMode (inclusive/exclusive)
- Calculation methods


##  Learning Points

Through this project, I learned:
- Flutter form handling and validation
- Dynamic list management (add/remove items)
- State management with setState
- Real-time calculations
- Model-based architecture
- Responsive UI design
- Material Design principles

##  Known Issues

- Print functionality is a placeholder (needs implementation)
- No data persistence (quotes are not saved) no database added as of now

##  Future Enhancements

- [ ] Save quotes locally using shared_preferences or SQLite
- [ ] Export quotes as PDF
- [ ] Email/Share functionality
- [ ] Quote history and search
- [ ] Multiple currency support
- [ ] Dark mode support
- [ ] Quote templates
- [ ] Client database

##  Screenshots
-[Home Page](lib/assets/homepage.jpg)
-[Preview Page](lib/assets/preview.jpg)


1. Main Form - Filled with sample data
2. Line Items - Multiple items added
3. Preview - Professional quote layout

## Contributing

This is a personal project for internship assessment. However, suggestions and feedback are welcome!

##  Developer

Hitesh kumar singh
- Second Year Student(3rd sem)
- I.K.Gujral Punjab Technical university main campus kapurthala ,punjab
- Email: hiteshkumarsingh7777@gmail.com
- LinkedIn: https://www.linkedin.com/in/hitesh-singh-46b611355/


##  Internship Assessment

This project was created as part of the Flutter Developer internship assessment. It demonstrates:
- Understanding of Flutter basics
- Form handling and validation
- State management
- Business logic implementation
- UI/UX design principles
- Code organization and structure

##  License

This project is created for educational purposes as part of an internship assessment.

##  Acknowledgments

- Flutter documentation and community
- Material Design guidelines
- The internship team for the opportunity



