import 'package:equatable/equatable.dart';

import '../../data/models/my_product_item_model.dart';

enum MyProductsLoadingType {
  none,
  loadingProducts,
  addingProduct,
  updatingProduct,
  deletingProduct,
  addingBrand,
  pickingImage,
}

abstract class MyProductsState extends Equatable {
  const MyProductsState();

  @override
  List<Object?> get props => [];
}

class MyProductsInitial extends MyProductsState {}

class MyProductsFormData extends MyProductsState {
  final String? selectedCategoryName;
  final int? selectedCategoryId;
  final String? selectedBrand;
  final String? selectedSize;
  final String? selectedType;
  final String? selectedMaterial;
  final String? selectedImagePath;
  final String? productName;
  final String? quantity;
  final String? description;

  const MyProductsFormData({
    this.selectedCategoryName,
    this.selectedCategoryId,
    this.selectedBrand,
    this.selectedSize,
    this.selectedType,
    this.selectedMaterial,
    this.selectedImagePath,
    this.productName,
    this.quantity,
    this.description,
  });

  @override
  List<Object?> get props => [
    selectedCategoryName,
    selectedCategoryId,
    selectedBrand,
    selectedSize,
    selectedType,
    selectedMaterial,
    selectedImagePath,
    productName,
    quantity,
    description,
  ];

  MyProductsFormData copyWith({
    String? selectedCategoryName,
    int? selectedCategoryId,
    String? selectedBrand,
    String? selectedSize,
    String? selectedType,
    String? selectedMaterial,
    String? selectedImagePath,
    String? productName,
    String? quantity,
    String? description,
  }) {
    return MyProductsFormData(
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedType: selectedType ?? this.selectedType,
      selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }
}

class MyProductsLoading extends MyProductsState {
  final MyProductsLoadingType loadingType;

  const MyProductsLoading({
    this.loadingType = MyProductsLoadingType.loadingProducts,
  });

  @override
  List<Object?> get props => [loadingType];
}

class ImagePickingLoading extends MyProductsState {
  final MyProductsLoadingType loadingType;

  const ImagePickingLoading({
    this.loadingType = MyProductsLoadingType.pickingImage,
  });

  @override
  List<Object?> get props => [loadingType];
}

class ImagePickedSuccess extends MyProductsState {
  final String imagePath;

  const ImagePickedSuccess({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class ImagePickingFailure extends MyProductsState {
  final String message;

  const ImagePickingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MyProductsLoaded extends MyProductsState {
  final List<MyProductItemModel> products;
  final String? searchQuery;

  const MyProductsLoaded({required this.products, this.searchQuery});

  @override
  List<Object?> get props => [products, searchQuery];
}

class AddProductSuccess extends MyProductsState {
  final String message;

  const AddProductSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteProductSuccess extends MyProductsState {
  final String message;

  const DeleteProductSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class MyProductsFailure extends MyProductsState {
  final String message;

  const MyProductsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MyProductsValidationError extends MyProductsState {
  final String? nameError;
  final String? categoryError;
  final String? brandError;
  final String? sizeError;
  final String? typeError;
  final String? quantityError;
  final String? imageError;
  final String? materialError;
  final String? descriptionError;

  const MyProductsValidationError({
    this.nameError,
    this.categoryError,
    this.brandError,
    this.sizeError,
    this.typeError,
    this.quantityError,
    this.imageError,
    this.materialError,
    this.descriptionError,
  });

  @override
  List<Object?> get props => [
    nameError,
    categoryError,
    brandError,
    sizeError,
    typeError,
    quantityError,
    imageError,
    materialError,
    descriptionError,
  ];

  bool get hasErrors =>
      nameError != null ||
      categoryError != null ||
      brandError != null ||
      sizeError != null ||
      typeError != null ||
      quantityError != null ||
      imageError != null ||
      materialError != null;
  // Description is optional, so we don't check for description errors
}

class AddBrandLoading extends MyProductsState {
  final MyProductsLoadingType loadingType;

  const AddBrandLoading({this.loadingType = MyProductsLoadingType.addingBrand});

  @override
  List<Object?> get props => [loadingType];
}

class AddBrandSuccess extends MyProductsState {
  final Map<String, dynamic> response;

  const AddBrandSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class BrandTypeMaterialLoading extends MyProductsState {}

class BrandTypeMaterialLoaded extends MyProductsState {
  final List<Map<String, dynamic>> brands;
  final List<Map<String, dynamic>> types;
  final List<Map<String, dynamic>> materials;
  final List<Map<String, dynamic>> sizes;

  const BrandTypeMaterialLoaded({
    required this.brands,
    required this.types,
    required this.materials,
    required this.sizes,
  });

  @override
  List<Object?> get props => [brands, types, materials, sizes];
}
