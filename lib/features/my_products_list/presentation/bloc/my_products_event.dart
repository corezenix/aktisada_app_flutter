import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class MyProductsEvent extends Equatable {
  const MyProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyProducts extends MyProductsEvent {}

class SearchMyProducts extends MyProductsEvent {
  final String query;

  const SearchMyProducts({required this.query});

  @override
  List<Object?> get props => [query];
}

class LoadMyProductsWithFilters extends MyProductsEvent {
  final Map<String, dynamic> filters;

  const LoadMyProductsWithFilters({required this.filters});

  @override
  List<Object?> get props => [filters];
}

class ValidateAddProductForm extends MyProductsEvent {
  final String? productTitle;
  final String? categoryId;
  final String? brandId;
  final String? size;
  final String? typeId;
  final String? quantity;
  final File? imageFile;
  final String? materialId;
  final String? description;

  const ValidateAddProductForm({
    this.productTitle,
    this.categoryId,
    this.brandId,
    this.size,
    this.typeId,
    this.quantity,
    this.imageFile,
    this.materialId,
    this.description,
  });

  @override
  List<Object?> get props => [
    productTitle,
    categoryId,
    brandId,
    size,
    typeId,
    quantity,
    imageFile,
    materialId,
    description,
  ];
}

class AddProductRequested extends MyProductsEvent {
  final String productTitle;
  final String categoryId;
  final String brandId;
  final String size;
  final String sizeId;
  final String typeId;
  final String quantity;
  final File imageFile;
  final String? materialId;
  final String? description;

  const AddProductRequested({
    required this.productTitle,
    required this.categoryId,
    required this.brandId,
    required this.size,
    required this.sizeId,
    required this.typeId,
    required this.quantity,
    required this.imageFile,
    this.materialId,
    this.description,
  });

  @override
  List<Object?> get props => [
    productTitle,
    categoryId,
    brandId,
    size,
    sizeId,
    typeId,
    quantity,
    imageFile,
    materialId,
    description,
  ];
}

class UpdateProductRequested extends MyProductsEvent {
  final String productId;
  final String productTitle;
  final String categoryId;
  final String brandId;
  final String size;
  final String sizeId;
  final String typeId;
  final String quantity;
  final File imageFile;
  final String? materialId;
  final String? description;

  const UpdateProductRequested({
    required this.productId,
    required this.productTitle,
    required this.categoryId,
    required this.brandId,
    required this.size,
    required this.sizeId,
    required this.typeId,
    required this.quantity,
    required this.imageFile,
    this.materialId,
    this.description,
  });

  @override
  List<Object?> get props => [
    productId,
    productTitle,
    categoryId,
    brandId,
    size,
    sizeId,
    typeId,
    quantity,
    imageFile,
    materialId,
    description,
  ];
}

class DeleteProductRequested extends MyProductsEvent {
  final String productId;

  const DeleteProductRequested({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class ClearMyProductsValidationErrors extends MyProductsEvent {}

class PickImageFromGallery extends MyProductsEvent {}

class PickImageFromCamera extends MyProductsEvent {}

class ClearSelectedImage extends MyProductsEvent {}

class AddBrandRequested extends MyProductsEvent {
  final String brandName;
  final int categoryId;

  const AddBrandRequested(this.brandName, {required this.categoryId});

  @override
  List<Object?> get props => [brandName, categoryId];
}

class UpdateFormData extends MyProductsEvent {
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

  const UpdateFormData({
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
}

class ClearFormData extends MyProductsEvent {}

class GetBrandTypeMaterialRequested extends MyProductsEvent {
  final int categoryId;

  const GetBrandTypeMaterialRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
