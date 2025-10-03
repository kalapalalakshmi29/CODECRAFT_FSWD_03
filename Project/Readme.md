# StyleHub - Fashion E-commerce Application

A comprehensive Flutter-based fashion e-commerce mobile application with backend integration for trendy online shopping experience.

## Features

- **User Authentication**: Secure login and registration system
- **Product Catalog**: Browse and search products with categories
- **Shopping Cart**: Add, remove, and manage cart items
- **Order Management**: Place orders and track order history
- **User Profile**: Manage personal information and preferences
- **Payment Integration**: Secure payment processing
- **Responsive Design**: Optimized for mobile and tablet devices
- **Backend API**: Node.js server with database integration

## Setup Instructions

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Backend Setup**:
   ```bash
   cd backend
   npm install
   npm start
   ```

3. **Run the Application**:
   ```bash
   flutter run
   ```

## Usage

1. **Registration/Login**: Create account or login with existing credentials
2. **Browse Products**: Explore product categories and search items
3. **Add to Cart**: Select products and add them to shopping cart
4. **Checkout**: Complete purchase with payment processing
5. **Order Tracking**: View order history and track deliveries

## Architecture

- **Models**: Product, User, Order, Cart data structures
- **Services**: API communication, authentication, and data management
- **Screens**: Login, Home, Product, Cart, Profile UI components
- **Backend**: Node.js REST API with database integration
- **State Management**: Provider pattern for app state

## Dependencies

- `http`: API communication
- `provider`: State management
- `shared_preferences`: Local data storage
- `image_picker`: Image selection functionality
- `intl`: Internationalization support
- `flutter_secure_storage`: Secure credential storage

## Project Structure

```
lib/
├── models/
│   ├── user.dart
│   ├── product.dart
│   ├── cart.dart
│   └── order.dart
├── services/
│   ├── auth_service.dart
│   ├── api_service.dart
│   └── cart_service.dart
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── product_screen.dart
│   ├── cart_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── product_card.dart
│   ├── cart_item.dart
│   └── custom_button.dart
├── providers/
│   ├── auth_provider.dart
│   ├── product_provider.dart
│   └── cart_provider.dart
backend/
├── models/
├── routes/
├── middleware/
├── config/
└── server.js
└── main.dart
```

## Getting Started

This project is a complete e-commerce solution built with Flutter for the frontend and Node.js for the backend, providing a full-stack mobile shopping experience.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
