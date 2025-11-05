import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/validation_helper.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../data/models/my_product_item_model.dart';
import 'my_products_event.dart';
import 'my_products_state.dart';

class MyProductsBloc extends Bloc<MyProductsEvent, MyProductsState> {
  final ProductRepository productRepository;
  final LocalStorageService localStorageService;
  final ImagePicker _imagePicker = ImagePicker();

  MyProductsBloc({
    required this.productRepository,
    required this.localStorageService,
  }) : super(MyProductsInitial()) {
    on<LoadMyProducts>(_onLoadMyProducts);
    on<LoadMyProductsWithFilters>(_onLoadMyProductsWithFilters);
    on<SearchMyProducts>(_onSearchMyProducts);
    on<ValidateAddProductForm>(_onValidateAddProductForm);
    on<AddProductRequested>(_onAddProductRequested);
    on<UpdateProductRequested>(_onUpdateProductRequested);
    on<DeleteProductRequested>(_onDeleteProductRequested);
    on<ClearMyProductsValidationErrors>(_onClearMyProductsValidationErrors);
    on<PickImageFromGallery>(_onPickImageFromGallery);
    on<PickImageFromCamera>(_onPickImageFromCamera);
    on<ClearSelectedImage>(_onClearSelectedImage);
    on<AddBrandRequested>(_onAddBrandRequested);
    on<UpdateFormData>(_onUpdateFormData);
    on<ClearFormData>(_onClearFormData);
    on<GetBrandTypeMaterialRequested>(_onGetBrandTypeMaterialRequested);
  }

  Future<void> _onLoadMyProducts(
    LoadMyProducts event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(MyProductsLoading(loadingType: MyProductsLoadingType.loadingProducts));

    try {
      // Get user ID from local storage
      final userId = localStorageService.getUserId();
      if (userId == null) {
        emit(MyProductsFailure(message: 'User not authenticated'));
        return;
      }

      // Call the real API to get my products
      final filters = <String, dynamic>{
        'user_id': userId.toString(),
        'category_id': '',
        'brand_id': '',
        'type_id': '',
        'material_id': '',
        'item_size': '',
        'search': '',
      };

      final result = await productRepository.getMyProducts(filters);

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          final products = response.data.data.map((product) {
            return MyProductItemModel.fromJson(product.toJson());
          }).toList();

          emit(MyProductsLoaded(products: products));
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(
          message: 'Failed to load my products: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLoadMyProductsWithFilters(
    LoadMyProductsWithFilters event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(MyProductsLoading(loadingType: MyProductsLoadingType.loadingProducts));

    try {
      // Get user ID from local storage
      final userId = localStorageService.getUserId();
      if (userId == null) {
        emit(MyProductsFailure(message: 'User not authenticated'));
        return;
      }

      // Add user_id to filters
      final filters = Map<String, dynamic>.from(event.filters);
      filters['user_id'] = userId.toString();

      final result = await productRepository.getMyProducts(filters);

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          final products = response.data.data.map((product) {
            return MyProductItemModel.fromJson(product.toJson());
          }).toList();

          emit(MyProductsLoaded(products: products));
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(
          message: 'Failed to load my products with filters: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onSearchMyProducts(
    SearchMyProducts event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(MyProductsLoading(loadingType: MyProductsLoadingType.loadingProducts));

    try {
      // Get user ID from local storage
      final userId = localStorageService.getUserId();
      if (userId == null) {
        emit(MyProductsFailure(message: 'User not authenticated'));
        return;
      }

      // Call the real API with search filter
      final filters = <String, dynamic>{
        'user_id': userId.toString(),
        'category_id': '',
        'brand_id': '',
        'type_id': '',
        'material_id': '',
        'item_size': '',
        'search': event.query,
      };

      final result = await productRepository.getMyProducts(filters);

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          final products = response.data.data.map((product) {
            return MyProductItemModel.fromJson(product.toJson());
          }).toList();

          emit(MyProductsLoaded(products: products, searchQuery: event.query));
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(
          message: 'Failed to search my products: ${e.toString()}',
        ),
      );
    }
  }

  void _onValidateAddProductForm(
    ValidateAddProductForm event,
    Emitter<MyProductsState> emit,
  ) {
    final nameError = ValidationHelper.validateRequired(
      event.productTitle,
      'Product name',
    );
    final categoryError = ValidationHelper.validateDropdown(
      event.categoryId,
      'category',
    );
    final brandError = ValidationHelper.validateDropdown(
      event.brandId,
      'brand',
    );
    final sizeError = ValidationHelper.validateRequired(event.size, 'Size');
    final typeError = ValidationHelper.validateDropdown(event.typeId, 'type');
    final quantityError = ValidationHelper.validatePositiveInteger(
      event.quantity,
      'Quantity',
    );
    final imageError = ValidationHelper.validateImage(event.imageFile);
    final materialError = ValidationHelper.validateDropdown(
      event.materialId,
      'material',
    );
    // Description is optional, so no validation needed

    emit(
      MyProductsValidationError(
        nameError: nameError,
        categoryError: categoryError,
        brandError: brandError,
        sizeError: sizeError,
        typeError: typeError,
        quantityError: quantityError,
        imageError: imageError,
        materialError: materialError,
        descriptionError: null, // Description is optional
      ),
    );
  }

  Future<void> _onAddProductRequested(
    AddProductRequested event,
    Emitter<MyProductsState> emit,
  ) async {
    // First validate the form
    final nameError = ValidationHelper.validateRequired(
      event.productTitle,
      'Product name',
    );
    final categoryError = ValidationHelper.validateDropdown(
      event.categoryId,
      'category',
    );
    final brandError = ValidationHelper.validateDropdown(
      event.brandId,
      'brand',
    );
    final sizeError = ValidationHelper.validateRequired(event.size, 'Size');
    final typeError = ValidationHelper.validateDropdown(event.typeId, 'type');
    final quantityError = ValidationHelper.validatePositiveInteger(
      event.quantity,
      'Quantity',
    );
    final imageError = ValidationHelper.validateImage(event.imageFile);
    final materialError = ValidationHelper.validateDropdown(
      event.materialId,
      'material',
    );
    // Description is optional, so no validation needed

    if (nameError != null ||
        categoryError != null ||
        brandError != null ||
        sizeError != null ||
        typeError != null ||
        quantityError != null ||
        imageError != null ||
        materialError != null) {
      emit(
        MyProductsValidationError(
          nameError: nameError,
          categoryError: categoryError,
          brandError: brandError,
          sizeError: sizeError,
          typeError: typeError,
          quantityError: quantityError,
          imageError: imageError,
          materialError: materialError,
          descriptionError: null, // Description is optional
        ),
      );
      return;
    }

    emit(MyProductsLoading(loadingType: MyProductsLoadingType.addingProduct));

    try {
      // Get the current state to access categories, brands, types, materials
      final currentState = state;

      // Get user ID from local storage
      final userId = localStorageService.getUserId();
      if (userId == null) {
        emit(MyProductsFailure(message: 'User not authenticated'));
        return;
      }

      // Prepare the product data for API call
      final productData = <String, dynamic>{
        'name': event.productTitle,
        'user_id': userId.toString(),
        'category_id': _getCategoryId(event.categoryId, currentState),
        'brand_id': _getBrandId(event.brandId, currentState),
        'type_id': _getTypeId(event.typeId, currentState),
        'material_id': _getMaterialId(event.materialId, currentState),
        'size': event.size,
        'item_size_id': event.sizeId,
        'quantity': event.quantity,
        'image_file':
            event.imageFile, // This should be a File object for upload
        'description': event.description ?? '',
      };

      // Print the payload for debugging
      print('🚀 ADD PRODUCT PAYLOAD:');
      print('   Raw Data: $productData');
      print('   Brand ID: ${_getBrandId(event.brandId, currentState)}');
      print('   Type ID: ${_getTypeId(event.typeId, currentState)}');
      print(
        '   Material ID: ${_getMaterialId(event.materialId, currentState)}',
      );
      print('   Size: ${event.size}');
      print('   Size ID: ${event.sizeId}');
      print('=====================================');

      // Call the real API to add product
      final result = await productRepository.addProduct(productData);

      result.fold(
        (failure) {
          final errorMessage = failure.message;
          emit(MyProductsFailure(message: errorMessage));
        },
        (response) {
          emit(AddProductSuccess(message: 'Product added successfully!'));
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(message: 'Failed to add product: ${e.toString()}'),
      );
    }
  }

  Future<void> _onUpdateProductRequested(
    UpdateProductRequested event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(MyProductsLoading(loadingType: MyProductsLoadingType.updatingProduct));

    try {
      // Get the current state to access categories, brands, types, materials
      final currentState = state;

      // Get user ID from local storage
      final userId = localStorageService.getUserId();
      if (userId == null) {
        emit(MyProductsFailure(message: 'User not authenticated'));
        return;
      }

      // Prepare the product data for API call
      final productData = <String, dynamic>{
        'product_id': event.productId,
        'name': event.productTitle,
        'user_id': userId.toString(),
        'category_id': _getCategoryId(event.categoryId, currentState),
        'brand_id': _getBrandId(event.brandId, currentState),
        'type_id': _getTypeId(event.typeId, currentState),
        'material_id': _getMaterialId(event.materialId, currentState),
        'size': event.size,
        'item_size_id': event.sizeId,
        'quantity': event.quantity,
        'image_file': event.imageFile,
        'image_url': event.imageUrl,
        'description': event.description ?? '',
      };

      // Print the payload for debugging
      print('🚀 UPDATE PRODUCT PAYLOAD:');
      print('   Raw Data: $productData');
      print('   Brand ID: ${_getBrandId(event.brandId, currentState)}');
      print('   Size ID: ${event.sizeId}');
      print('   Type ID: ${_getTypeId(event.typeId, currentState)}');
      print(
        '   Material ID: ${_getMaterialId(event.materialId, currentState)}',
      );
      print('   Size: ${event.size}');
      print('=====================================');

      // Call the real API to update product
      final result = await productRepository.updateProduct(productData);

      result.fold(
        (failure) {
          final errorMessage = failure.message;
          emit(MyProductsFailure(message: errorMessage));
        },
        (response) {
          emit(AddProductSuccess(message: 'Product updated successfully!'));
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(message: 'Failed to update product: ${e.toString()}'),
      );
    }
  }

  Future<void> _onDeleteProductRequested(
    DeleteProductRequested event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(MyProductsLoading(loadingType: MyProductsLoadingType.deletingProduct));

    try {
      // Call the real API to delete product
      final result = await productRepository.deleteProduct(
        int.parse(event.productId),
      );

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          emit(
            const DeleteProductSuccess(
              message: 'Product deleted successfully!',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(message: 'Failed to delete product: ${e.toString()}'),
      );
    }
  }

  void _onClearMyProductsValidationErrors(
    ClearMyProductsValidationErrors event,
    Emitter<MyProductsState> emit,
  ) {
    emit(MyProductsInitial());
  }

  Future<void> _onPickImageFromGallery(
    PickImageFromGallery event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(ImagePickingLoading(loadingType: MyProductsLoadingType.pickingImage));

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        emit(ImagePickedSuccess(imagePath: image.path));
      } else {
        emit(ImagePickingFailure(message: 'No image selected'));
      }
    } catch (e) {
      emit(ImagePickingFailure(message: 'Failed to pick image: $e'));
    }
  }

  Future<void> _onPickImageFromCamera(
    PickImageFromCamera event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(ImagePickingLoading(loadingType: MyProductsLoadingType.pickingImage));

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        emit(ImagePickedSuccess(imagePath: image.path));
      } else {
        emit(ImagePickingFailure(message: 'No image captured'));
      }
    } catch (e) {
      emit(ImagePickingFailure(message: 'Failed to capture image: $e'));
    }
  }

  void _onClearSelectedImage(
    ClearSelectedImage event,
    Emitter<MyProductsState> emit,
  ) {
    emit(MyProductsInitial());
  }

  // Helper methods to get IDs from names
  String _getCategoryId(String? categoryName, MyProductsState state) {
    // For now, return the name as is - the API will handle the mapping
    // TODO: Implement proper category ID mapping from ProductBloc state
    return categoryName ?? '';
  }

  String _getBrandId(String? brandName, MyProductsState state) {
    if (brandName == null) return '';

    if (state is BrandTypeMaterialLoaded) {
      final brand = state.brands.firstWhere(
        (b) => b['name'] == brandName,
        orElse: () => {'id': '', 'name': ''},
      );
      return brand['id'] != null ? brand['id'].toString() : '';
    }

    return brandName;
  }

  String _getTypeId(String? typeName, MyProductsState state) {
    if (typeName == null) return '';

    if (state is BrandTypeMaterialLoaded) {
      final type = state.types.firstWhere(
        (t) => t['name'] == typeName,
        orElse: () => {'id': '', 'name': ''},
      );
      return type['id'] != null ? type['id'].toString() : '';
    }

    return typeName;
  }

  String _getMaterialId(String? materialName, MyProductsState state) {
    if (materialName == null) return '';

    if (state is BrandTypeMaterialLoaded) {
      final material = state.materials.firstWhere(
        (m) => m['name'] == materialName,
        orElse: () => {'id': '', 'name': ''},
      );
      return material['id'] != null ? material['id'].toString() : '';
    }

    return materialName;
  }

  Future<void> _onAddBrandRequested(
    AddBrandRequested event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(AddBrandLoading(loadingType: MyProductsLoadingType.addingBrand));

    try {
      final result = await productRepository.addBrand(
        event.brandName,
        categoryId: event.categoryId,
      );

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          emit(AddBrandSuccess(response: response));

          add(GetBrandTypeMaterialRequested(event.categoryId));
        },
      );
    } catch (e) {
      emit(MyProductsFailure(message: 'Failed to add brand: ${e.toString()}'));
    }
  }

  void _onUpdateFormData(UpdateFormData event, Emitter<MyProductsState> emit) {
    final currentState = state;
    if (currentState is MyProductsFormData) {
      emit(
        currentState.copyWith(
          selectedCategoryName: event.selectedCategoryName,
          selectedCategoryId: event.selectedCategoryId,
          selectedBrand: event.selectedBrand,
          selectedSize: event.selectedSize,
          selectedType: event.selectedType,
          selectedMaterial: event.selectedMaterial,
          selectedImagePath: event.selectedImagePath,
          productName: event.productName,
          quantity: event.quantity,
          description: event.description,
        ),
      );
    } else {
      emit(
        MyProductsFormData(
          selectedCategoryName: event.selectedCategoryName,
          selectedCategoryId: event.selectedCategoryId,
          selectedBrand: event.selectedBrand,
          selectedSize: event.selectedSize,
          selectedType: event.selectedType,
          selectedMaterial: event.selectedMaterial,
          selectedImagePath: event.selectedImagePath,
          productName: event.productName,
          quantity: event.quantity,
          description: event.description,
        ),
      );
    }
  }

  void _onClearFormData(ClearFormData event, Emitter<MyProductsState> emit) {
    emit(MyProductsInitial());
  }

  Future<void> _onGetBrandTypeMaterialRequested(
    GetBrandTypeMaterialRequested event,
    Emitter<MyProductsState> emit,
  ) async {
    emit(BrandTypeMaterialLoading());

    try {
      final result = await productRepository.getBrandTypeMaterial(
        event.categoryId,
      );

      result.fold(
        (failure) {
          emit(MyProductsFailure(message: failure.message));
        },
        (response) {
          final brands = response.data.brands
              .map((b) => {'id': b.id, 'name': b.brandName})
              .toList();
          final types = response.data.types
              .map((t) => {'id': t.id, 'name': t.typeName})
              .toList();
          final materials = response.data.materials
              .map((m) => {'id': m.id, 'name': m.materialName})
              .toList();
          final sizes = response.data.sizes
              .map((s) => {'id': s.id, 'name': s.itemSize})
              .toList();

          emit(
            BrandTypeMaterialLoaded(
              brands: brands,
              types: types,
              materials: materials,
              sizes: sizes,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        MyProductsFailure(
          message:
              'Failed to load brand, type, material, and size data: ${e.toString()}',
        ),
      );
    }
  }
}
