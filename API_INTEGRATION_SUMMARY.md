# API Integration Summary

This document summarizes all the APIs that have been integrated into the Flutter app.

## Base Configuration

- **Base URL**: `https://app.calicult.com/api/v1`
- **API Constants File**: `lib/core/constants/api_endpoints.dart`
- **API Client**: `lib/core/network/api_client.dart`

## Integrated APIs

### 1. Authentication

- **Endpoint**: `/login`
- **Method**: POST
- **Description**: User login with mobile and password
- **Response Model**: `LoginResponse`
- **Usage**: Used in `AuthBloc` for user authentication

### 2. Slides

- **Endpoint**: `/get-slides`
- **Method**: GET
- **Description**: Get banner/slider images for home page
- **Response Model**: `SlidesResponse`
- **Usage**: Can be used in home page for banner carousel

### 3. Categories

- **Endpoint**: `/get-categories`
- **Method**: GET
- **Description**: Get all product categories
- **Response Model**: `CategoriesResponse`
- **Usage**: Used in product filtering and category selection

### 4. Brand, Type, Material, Size

- **Endpoint**: `/get-brand-type-material`
- **Method**: POST
- **Description**: Get brands, types, materials, and sizes for a specific category
- **Response Model**: `BrandTypeMaterialResponse`
- **Usage**: Used in add product form and product filtering

### 5. Filters

- **Endpoint**: `/get-filters`
- **Method**: POST
- **Description**: Get all available filters for a category
- **Response Model**: `FiltersResponse`
- **Usage**: Used in product filtering page

### 6. Add Product

- **Endpoint**: `/add-product`
- **Method**: POST
- **Description**: Add a new product
- **Response Model**: `AddProductResponse`
- **Usage**: Used in add product form

### 7. Add Brand

- **Endpoint**: `/add-brand`
- **Method**: POST
- **Description**: Add a new brand
- **Response Model**: Generic response
- **Usage**: Used in brand management

### 8. Product List

- **Endpoint**: `/product-list`
- **Method**: POST
- **Description**: Get filtered product list
- **Response Model**: `ProductListResponse`
- **Usage**: Used in product listing with filters

### 9. Delete Product

- **Endpoint**: `/delete-product`
- **Method**: POST
- **Description**: Delete a product
- **Response Model**: Generic response
- **Usage**: Used in product management

### 10. Edit Product

- **Endpoint**: `/edit-product`
- **Method**: POST
- **Description**: Get product details for editing
- **Response Model**: List of `ProductModel`
- **Usage**: Used in edit product form

### 11. Update Product

- **Endpoint**: `/update-product`
- **Method**: POST
- **Description**: Update an existing product
- **Response Model**: Generic response
- **Usage**: Used in edit product form

### 12. Product Details

- **Endpoint**: `/product-details`
- **Method**: POST
- **Description**: Get detailed product information
- **Response Model**: List of `ProductModel`
- **Usage**: Used in product detail page

### 13. My Products

- **Endpoint**: `/get-my-products`
- **Method**: POST
- **Description**: Get user's own products with pagination
- **Response Model**: `MyProductsResponse`
- **Usage**: Used in my products list page

## Data Models Created

### Auth Models

- `UserModel` - User information
- `LoginResponse` - Login API response

### Product Models

- `ProductModel` - Product information
- `CategoryModel` - Category information
- `BrandModel` - Brand information
- `TypeModel` - Type information
- `MaterialModel` - Material information
- `SizeModel` - Size information
- `SlideModel` - Banner/slider information

### Response Models

- `SlidesResponse` - Slides API response
- `CategoriesResponse` - Categories API response
- `BrandTypeMaterialResponse` - Brand type material API response
- `FiltersResponse` - Filters API response
- `ProductListResponse` - Product list API response
- `MyProductsResponse` - My products API response with pagination
- `AddProductResponse` - Add product API response

## Repository Layer

### Auth Repository

- `AuthRepository` interface
- `AuthRepositoryImpl` implementation
- Handles login functionality

### Product Repository

- `ProductRepository` interface
- `ProductRepositoryImpl` implementation
- Handles all product-related API calls

## Data Sources

### Auth Remote Data Source

- `AuthRemoteDataSource` interface
- `AuthRemoteDataSourceImpl` implementation
- Makes HTTP calls to auth endpoints

### Product Remote Data Source

- `ProductRemoteDataSource` interface
- `ProductRemoteDataSourceImpl` implementation
- Makes HTTP calls to product endpoints

## Usage Examples

### Login

```dart
final authBloc = getIt<AuthBloc>();
authBloc.add(LoginRequested(mobile: '1234567899', password: '123456'));
```

### Get Categories

```dart
final productRepository = getIt<ProductRepository>();
final result = await productRepository.getCategories();
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (categories) => print('Categories: ${categories.data.categories.length}'),
);
```

### Add Product

```dart
final productData = {
  'product_title': 'Product Name',
  'user_id': '1',
  'category_id': '2',
  'brand_id': '1',
  'type_id': '2',
  'material_id': '2',
  'item_size': '10x15x5 inch',
  'quantity': '5',
  'image_file': imageFile,
  'flush_type': '',
};

final result = await productRepository.addProduct(productData);
```

## Error Handling

All API calls use proper error handling with:

- HTTP status code validation
- Dio exception handling
- Custom error messages
- Either type for success/failure handling

## Authentication

- Login API automatically sets the Bearer token
- Token is stored in API client headers
- All subsequent API calls include the token automatically

## File Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── api_endpoints.dart
│   └── network/
│       └── api_client.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   └── domain/
│   └── product/
│       ├── data/
│       │   ├── models/
│       │   ├── datasources/
│       │   └── repositories/
│       └── domain/
└── di/
    └── injector.dart
```

## Next Steps

1. Update UI components to use the new models
2. Implement proper error handling in UI
3. Add loading states for API calls
4. Implement proper form validation
5. Add image upload functionality for products
6. Implement pagination in product lists
7. Add search functionality
8. Implement proper state management for all features
