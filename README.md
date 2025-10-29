# Fake Store App - Flutter E-Commerce Application

A fully functional Flutter e-commerce application built with clean architecture, following best practices and modern Flutter development patterns.

## Features

### Implemented Features

1. **Authentication**

   - Login with Fake Store API
   - Field validation (username & password)
   - Show/hide password functionality
   - Error handling and loading states

2. **Product Listing**

   - Fetch products from Fake Store API
   - Display product name, image, price, and rating
   - Lazy loading support (ready for pagination)
   - Pull-to-refresh functionality

3. **Product Details**

   - Full product description
   - Category display
   - Rating with review count
   - Add to cart functionality
   - Add/remove from wishlist

4. **Cart Management**

   - Add/remove products from cart
   - Update product quantity
   - Display cart total price
   - Empty cart state
   - Persistent cart during session

5. **Wishlist (Local Storage)**
   - Add/remove products from wishlist
   - View all wishlist products
   - Add wishlist items to cart
   - Persistent storage using `shared_preferences`

## Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/          # API endpoints and app constants
│   ├── di/                 # Dependency injection setup
│   ├── routes/             # Navigation configuration
│   ├── theme/              # App theme (Urbanist font)
│   └── utils/              # Validators and helpers
├── data/                   # Data layer
│   ├── datasources/        # API and local data sources
│   │   ├── local/         # SharedPreferences implementation
│   │   └── remote/        # API service with Dio
│   ├── models/            # Data models with JSON serialization
│   └── repositories/      # Repository implementations
└── presentation/          # Presentation layer
    ├── screens/           # Screen-specific BLoCs and UI
    │   ├── login/
    │   ├── products/
    │   ├── product_detail/
    │   ├── cart/
    │   └── wishlist/
    └── widgets/           # Reusable widgets
```

## Tech Stack

### Core Technologies

- **Flutter SDK**: ^3.0.0
- **Dart**: ^3.0.0

### State Management

- **flutter_bloc**: ^8.1.3 - Business Logic Component pattern
- **equatable**: ^2.0.5 - Value equality

### Dependency Injection

- **injectable**: ^2.3.2 - Code generation for DI
- **get_it**: ^7.6.4 - Service locator

### Networking

- **dio**: ^5.4.0 - HTTP client
- **pretty_dio_logger**: ^1.3.1 - Network logging

### Local Storage

- **shared_preferences**: ^2.2.2 - Key-value storage

### Navigation

- **go_router**: ^13.0.0 - Declarative routing

### UI Components

- **google_fonts**: ^6.1.0 - Urbanist font
- **gap**: ^3.0.1 - Spacing widget
- **cached_network_image**: ^3.3.0 - Image caching
- **flutter_rating_bar**: ^4.0.1 - Star ratings

### Code Generation

- **json_serializable**: ^6.7.1 - JSON serialization
- **build_runner**: ^2.4.7 - Code generation tool
- **injectable_generator**: ^2.4.1 - DI code generation

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd fake_store_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Login Credentials

Use these credentials to test the app:

- **Username**: `johnd`
- **Password**: `m38rmF$`

Alternative credentials:

- **Username**: `mor_2314`, **Password**: `83r5^_`
- **Username**: `kevinryan`, **Password**: `kev02937@`

## App Flow

1. **Login Screen**

   - Enter username and password
   - Validation on both fields
   - Show/hide password toggle
   - Loading state during authentication

2. **Products Screen**

   - View all products
   - Add products to wishlist (heart icon)
   - Tap product to view details
   - Bottom navigation for Home/Wishlist/Cart

3. **Product Detail Screen**

   - View full product information
   - See ratings and reviews
   - Add to cart
   - Toggle wishlist

4. **Cart Screen**

   - View cart items
   - Adjust quantities (+/- buttons)
   - Remove items
   - See total price
   - Proceed to checkout

5. **Wishlist Screen**
   - View saved items
   - Add items to cart
   - Remove from wishlist
   - Empty state when no items

## Design System

### Typography

- **Font Family**: Urbanist (Google Fonts)
- Clean, modern sans-serif typeface

### Spacing

- Uses `Gap` widget instead of `SizedBox` for consistent spacing
- Gap values: 4, 8, 12, 16, 24, 32

### Colors

- **Primary**: Black (#000000)
- **Background**: White (#FFFFFF)
- **Accent**: Red (for wishlist hearts)
- **Grey Scale**: Various grey shades for text and borders

### Components

- Rounded corners (8px border radius)
- Elevated buttons with 56px height
- Card-based layout for products
- Bottom navigation bar
- Material Design 3

## Testing

### Run Tests

```bash
flutter test
```

### Generate Coverage

```bash
flutter test --coverage
```

## Build

### Android APK

```bash
flutter build apk --release
```

### iOS IPA

```bash
flutter build ios --release
```

## Development

### Code Generation

When you modify models or add new injectable classes:

```bash
# Watch mode - automatically rebuilds on changes
flutter pub run build_runner watch

# One-time build
flutter pub run build_runner build --delete-conflicting-outputs
```

### Adding New Dependencies

1. Add to `pubspec.yaml`
2. Run `flutter pub get`
3. If it's a code-generation package, run build_runner

## API Documentation

### Base URL

```
https://fakestoreapi.com
```

### Endpoints Used

1. **Login**

   - POST `/auth/login`
   - Body: `{ "username": "string", "password": "string" }`

2. **Get All Products**

   - GET `/products`

3. **Get Single Product**
   - GET `/products/{id}`

## Development Time Estimate

**Total Time**: 8-12 hours

Breakdown:

- Project setup & architecture: 1-2 hours
- Data layer (models, repositories, API): 2-3 hours
- BLoC implementation: 2-3 hours
- UI implementation: 3-4 hours
- Testing & bug fixes: 1-2 hours

## Known Issues & Future Improvements

### Current Limitations

- No actual checkout functionality (API limitation)
- Products are not paginated (but architecture supports it)
- No search functionality
- No product filtering/sorting

### Future Enhancements

1. Add product search
2. Implement category filtering
3. Add user profile screen
4. Implement order history
5. Add animations and transitions
6. Implement deep linking
7. Add unit and widget tests
8. Implement CI/CD pipeline

## License

This project is created for educational and interview purposes.

## Author

Created as a technical assessment project demonstrating:

- Clean Architecture
- State Management (BLoC)
- Dependency Injection
- RESTful API integration
- Local storage
- Modern Flutter best practices

## Acknowledgments

- [Fake Store API](https://fakestoreapi.com/) for providing the test API
- Flutter and Dart teams for excellent documentation
- Community packages that made development easier

---

**Note**: This is a demo application using a public API. It's not intended for production use without proper authentication and security measures.
