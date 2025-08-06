# Restaurant Invoice Application

This is a Flutter application designed for managing restaurant invoices. The app provides a user-friendly interface for creating and managing invoices, viewing sales reports, and handling menu items without the need for backend integration.

## Features

- **Splash Screen**: Displays the restaurant logo and transitions to the login screen.
- **Login Screen**: Allows users to log in using email and password or PIN, with an option to skip login.
- **Home Dashboard**: Provides an overview of today's sales, number of invoices, top-selling items, pending payments, and a button to create a new invoice.
- **Create Invoice**: Users can add items from the menu, input quantities, prices, discounts, and taxes, auto-calculate totals, select payment types, and enter customer details. Includes "Save" and "Print Preview" buttons.
- **Invoice Preview**: Displays the invoice details in a printable format, including the restaurant logo, item list, totals, date, and invoice number.
- **Menu Management**: Lists food items with options to edit or delete, and includes a form to add new items.
- **Sales Report**: Displays tabs for daily, weekly, and monthly reports, lists past invoices, and includes a filter by date and export button.
- **Settings**: Allows users to manage restaurant details, default tax and discount settings, and toggle currency and theme.

## Project Structure

```
restaurant_invoice_app
├── lib
│   ├── main.dart
│   ├── app.dart
│   ├── screens
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── home_dashboard_screen.dart
│   │   ├── create_invoice_screen.dart
│   │   ├── invoice_preview_screen.dart
│   │   ├── menu_management_screen.dart
│   │   ├── sales_report_screen.dart
│   │   └── settings_screen.dart
│   ├── widgets
│   │   └── custom_widgets.dart
│   ├── models
│   │   └── invoice.dart
│   └── utils
│       └── constants.dart
├── pubspec.yaml
└── README.md
```

## Getting Started

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd restaurant_invoice_app
   ```

3. Install the dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for details.