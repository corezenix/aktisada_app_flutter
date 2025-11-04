import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/searchable_dropdown.dart';
import '../../../product/presentation/bloc/product_bloc.dart' as product_bloc;
import '../bloc/my_products_bloc.dart';
import '../bloc/my_products_event.dart';
import '../bloc/my_products_state.dart';

class AddProductPage extends StatefulWidget {
  final Map<String, dynamic>? productToEdit;

  const AddProductPage({super.key, this.productToEdit});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Keep the same UI structure but use API data
  List<String> productCategories = [];
  List<Map<String, dynamic>> brands = [];
  List<Map<String, dynamic>> types = [];
  List<Map<String, dynamic>> materials = [];
  List<Map<String, dynamic>> sizes = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Add brand dialog controller
  final TextEditingController _brandController = TextEditingController();

  bool get _isEditMode => widget.productToEdit != null;

  // Simple form data storage
  String? selectedCategoryName;
  String? selectedCategoryId;
  String? selectedBrand;
  String? selectedBrandId;
  String? selectedSize;
  String? selectedSizeId;
  String? selectedType;
  String? selectedTypeId;
  String? selectedMaterial;
  String? selectedMaterialId;
  String? selectedImagePath;

  // Store the product data from API for edit mode
  Map<String, dynamic>? _editProductData;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _initializeFormForEdit();
    }
    _loadCategories();
  }

  void _loadCategories() {
    context.read<product_bloc.ProductBloc>().add(
      product_bloc.GetCategoriesRequested(),
    );
  }

  void _loadBrandTypeMaterial(String categoryName) {
    // Find category ID by name
    final category = context.read<product_bloc.ProductBloc>().state;
    if (category is product_bloc.CategoriesLoaded) {
      final categoryModel = category.categories.data.categories.firstWhere(
        (cat) => cat.category == categoryName,
        orElse: () => category.categories.data.categories.first,
      );
      context.read<MyProductsBloc>().add(
        GetBrandTypeMaterialRequested(categoryModel.id),
      );
    }
  }

  void _onCategoryChanged(String? category) {
    if (category != null) {
      setState(() {
        selectedCategoryName = category;
        // Reset dependent fields when category changes (but preserve in edit mode)
        if (!_isEditMode) {
          selectedBrand = null;
          selectedType = null;
          selectedMaterial = null;
          selectedSize = null;
          selectedBrandId = null;
          selectedTypeId = null;
          selectedMaterialId = null;
          selectedSizeId = null;
        }
      });

      // Get category ID and store
      final categoryState = context.read<product_bloc.ProductBloc>().state;
      if (categoryState is product_bloc.CategoriesLoaded) {
        final categoryModel = categoryState.categories.data.categories
            .firstWhere(
              (cat) => cat.category == category,
              orElse: () => categoryState.categories.data.categories.first,
            );
        selectedCategoryId = categoryModel.id.toString();
      }

      _loadBrandTypeMaterial(category);
    }
  }

  void _pickImageFromGallery() {
    // Directly call gallery for image picking
    context.read<MyProductsBloc>().add(PickImageFromGallery());
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: AppTextStyles.base.w600.s16.l1,
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primary),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<MyProductsBloc>().add(PickImageFromCamera());
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.primary),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageContent() {
    if (selectedImagePath != null && selectedImagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            // Check if it's a network image (from edit mode) or local file
            selectedImagePath!.startsWith('http')
                ? Image.network(
                    selectedImagePath!,
                    width: 205.w,
                    height: 121.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildImagePlaceholder();
                    },
                  )
                : Image.file(
                    File(selectedImagePath!),
                    width: 205.w,
                    height: 121.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildImagePlaceholder();
                    },
                  ),
            // Only show close button if not in edit mode
            if (!_isEditMode)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = null;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16.sp, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_box_rounded, size: 32.sp, color: AppColors.primary),
        SizedBox(height: 6.h),
        Text('Tap to select image', style: AppTextStyles.base.w500.s13.l1),
        SizedBox(height: 4.h),
        Text(
          '(Camera or Gallery)',
          style: AppTextStyles.base.w400.s11.greyTextColor(),
        ),
      ],
    );
  }

  void _initializeFormForEdit() {
    // Use the existing product data directly - no need for API call
    _populateFormWithEditData(widget.productToEdit!);
  }

  void _populateFormWithEditData(Map<String, dynamic> productData) {
    // Store the product data for later use
    _editProductData = productData;

    // Populate form with data from existing product
    nameController.text =
        productData['product_title'] ?? productData['name'] ?? '';
    quantityController.text = (productData['quantity'] != null
        ? productData['quantity'].toString()
        : '');
    descriptionController.text = productData['description'] ?? '';

    setState(() {
      selectedCategoryId = productData['category_id']?.toString();
      selectedBrandId = productData['brand_id']?.toString();
      selectedTypeId = productData['type_id']?.toString();
      selectedMaterialId = productData['material_id']?.toString();
      selectedImagePath = productData['image_path'] ?? productData['imageFile'];

      // Handle item_size_id - check multiple possible fields
      selectedSizeId =
          productData['item_size_id']?.toString() ??
          productData['pk_size_id']?.toString() ??
          '';

      // Handle item_size - could be a custom size string or predefined size name
      selectedSize = productData['item_size'] ?? productData['size'] ?? '';

      // If we have a size_id but no size string, we'll need to load it from the sizes list
      // If we have a size string but no size_id, it's a custom size

      // Also set the display names for brand, type, and material
      selectedBrand = productData['brand_name'] ?? productData['brand'];
      selectedType = productData['type_name'] ?? productData['type'];
      selectedMaterial =
          productData['material_name'] ?? productData['material'];

      // Load category name and other names based on IDs
      _loadNamesFromIds(productData);
    });
  }

  void _loadNamesFromIds(Map<String, dynamic> productData) {
    // Load category name
    final categoryState = context.read<product_bloc.ProductBloc>().state;
    if (categoryState is product_bloc.CategoriesLoaded) {
      final categoryId = productData['category_id'];
      final category = categoryState.categories.data.categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => categoryState.categories.data.categories.first,
      );
      selectedCategoryName = category.category;

      // Load brand, type, material, size data for this category
      _loadBrandTypeMaterial(category.category);
    }
  }

  void _populateNamesFromLoadedData(Map<String, dynamic> productData) {
    // This method will be called after BrandTypeMaterialLoaded state
    // to populate the names based on the IDs
    if (brands.isNotEmpty &&
        types.isNotEmpty &&
        materials.isNotEmpty &&
        sizes.isNotEmpty) {
      setState(() {
        // Find brand name by ID (only if not already set)
        if (selectedBrand == null) {
          final brandId = productData['brand_id'];
          if (brandId != null) {
            final brand = brands.firstWhere(
              (b) => b['id'] == brandId,
              orElse: () => <String, Object>{
                'id': brandId,
                'name': 'Unknown Brand',
              },
            );
            selectedBrand = brand['name'];
          }
        }

        // Find type name by ID (only if not already set)
        if (selectedType == null) {
          final typeId = productData['type_id'];
          if (typeId != null) {
            final type = types.firstWhere(
              (t) => t['id'] == typeId,
              orElse: () => <String, Object>{
                'id': typeId,
                'name': 'Unknown Type',
              },
            );
            selectedType = type['name'];
          }
        }

        // Find material name by ID (only if not already set)
        if (selectedMaterial == null) {
          final materialId = productData['material_id'];
          if (materialId != null) {
            final material = materials.firstWhere(
              (m) => m['id'] == materialId,
              orElse: () => <String, Object>{
                'id': materialId,
                'name': 'Unknown Material',
              },
            );
            selectedMaterial = material['name'];
          }
        }

        // Find size name by ID - if we have a size_id, match it with the sizes list
        if (selectedSizeId != null &&
            selectedSizeId!.isNotEmpty &&
            sizes.isNotEmpty) {
          try {
            final sizeIdInt = int.parse(selectedSizeId!);
            final matchedSize = sizes.firstWhere(
              (s) => s['id'] == sizeIdInt,
              orElse: () => <String, Object>{},
            );
            if (matchedSize.isNotEmpty && matchedSize['name'] != null) {
              selectedSize = matchedSize['name'].toString();
            }
          } catch (e) {
            // If parsing fails, keep the existing selectedSize (which might be a custom size string)
            print('Could not parse size_id: $selectedSizeId');
          }
        }
        // If no size_id but we have item_size, it's a custom size - keep it as is
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    descriptionController.dispose();

    _brandController.dispose();
    super.dispose();
  }

  // Simple validation - just check if all required fields are filled
  bool _isFormValid() {
    return nameController.text.trim().isNotEmpty &&
        selectedCategoryName != null &&
        selectedBrandId != null &&
        selectedSize != null &&
        selectedSizeId != null &&
        selectedTypeId != null &&
        selectedMaterialId != null &&
        quantityController.text.trim().isNotEmpty &&
        selectedImagePath != null &&
        selectedImagePath!.isNotEmpty;
    // Note: Description is optional, so we don't validate it
  }

  void _handleAddProduct() {
    if (_isFormValid()) {
      // Handle image file - check if it's a network URL or local file
      File? imageFile;
      if (selectedImagePath != null && selectedImagePath!.isNotEmpty) {
        // Check if it's a network URL (starts with http) or local file path
        if (selectedImagePath!.startsWith('http://') ||
            selectedImagePath!.startsWith('https://')) {
          // It's a network URL - user didn't change the image
          // Pass null or empty - the API will keep the existing image
          imageFile = null;
        } else {
          // It's a local file path - user selected a new image
          imageFile = File(selectedImagePath!);
        }
      }

      if (_isEditMode) {
        // Update existing product
        final productId =
            widget.productToEdit!['id']?.toString() ??
            widget.productToEdit!['pk_product_id']?.toString() ??
            '';

        context.read<MyProductsBloc>().add(
          UpdateProductRequested(
            productId: productId,
            productTitle: nameController.text.trim(),
            categoryId: selectedCategoryId ?? '',
            brandId: selectedBrandId ?? '',
            size: selectedSize ?? '',
            sizeId: selectedSizeId ?? '',
            typeId: selectedTypeId ?? '',
            quantity: quantityController.text.trim(),
            imageFile: imageFile,
            materialId: selectedMaterialId ?? '',
            description: descriptionController.text.trim().isNotEmpty
                ? descriptionController.text.trim()
                : null,
          ),
        );
      } else {
        // Add new product - imageFile must not be null for new products
        if (imageFile == null) {
          // This shouldn't happen as validation requires an image
          return;
        }
        context.read<MyProductsBloc>().add(
          AddProductRequested(
            productTitle: nameController.text.trim(),
            categoryId: selectedCategoryId ?? '',
            brandId: selectedBrandId ?? '',
            size: selectedSize ?? '',
            sizeId: selectedSizeId ?? '',
            typeId: selectedTypeId ?? '',
            quantity: quantityController.text.trim(),
            imageFile: imageFile,
            materialId: selectedMaterialId ?? '',
            description: descriptionController.text.trim().isNotEmpty
                ? descriptionController.text.trim()
                : null,
          ),
        );
      }
    } else {
      // Show simple error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddBrandDialog() {
    _brandController.clear();
    showDialog(
      context: context,
      builder: (BuildContext cont) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Brand', style: AppTextStyles.base.w600.s16.l1),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      hintText: 'Enter brand name',
                      hintStyle: AppTextStyles.base.s14.greyTextColor(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {}); // Rebuild to update button state
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.base.w500.s14.greyTextColor(),
                  ),
                ),
                BlocBuilder<MyProductsBloc, MyProductsState>(
                  builder: (context, myProductsState) {
                    final isLoading = myProductsState is AddBrandLoading;
                    final brandName = _brandController.text.trim();
                    final isValid =
                        brandName.isNotEmpty && selectedCategoryName != null;

                    return ElevatedButton(
                      onPressed: (isLoading || !isValid)
                          ? null
                          : () async {
                              if (brandName.isNotEmpty &&
                                  selectedCategoryName != null) {
                                // Get category ID from the selected category name
                                final category = context
                                    .read<product_bloc.ProductBloc>()
                                    .state;
                                if (category is product_bloc.CategoriesLoaded) {
                                  final categoryModel = category
                                      .categories
                                      .data
                                      .categories
                                      .firstWhere(
                                        (cat) =>
                                            cat.category ==
                                            selectedCategoryName,
                                        orElse: () => category
                                            .categories
                                            .data
                                            .categories
                                            .first,
                                      );

                                  context.read<MyProductsBloc>().add(
                                    AddBrandRequested(
                                      brandName,
                                      categoryId: categoryModel.id,
                                    ),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Add',
                              style: AppTextStyles.base.w500.s14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit product' : 'Add product',
          style: AppTextStyles.base.w700.bold.s16.l1,
        ),
        centerTitle: false,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MyProductsBloc, MyProductsState>(
            listener: (context, state) {
              if (state is AddProductSuccess) {
                // Print the success message
                print('=== PRODUCT OPERATION SUCCESS ===');
                print('Message: ${state.message}');
                print('===========================');

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );

                // Close the page and refresh my products list
                Navigator.pop(context);
                context.read<MyProductsBloc>().add(LoadMyProducts());
              } else if (state is MyProductsFailure) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is ImagePickedSuccess) {
                setState(() {
                  selectedImagePath = state.imagePath;
                });
              } else if (state is ImagePickingFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is AddBrandSuccess) {
                // Close the add brand dialog if it's open
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                // Refresh brand list after adding new brand
                if (selectedCategoryName != null) {
                  // Reset brand selection since we're refreshing the list
                  setState(() {
                    selectedBrand = null;
                    selectedBrandId = null;
                  });
                  // Call the API to refresh brand, type, material, and size data
                  _loadBrandTypeMaterial(selectedCategoryName!);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Brand added successfully! Brand list will be refreshed automatically.',
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          BlocListener<product_bloc.ProductBloc, product_bloc.ProductState>(
            listener: (context, state) {
              if (state is product_bloc.CategoriesLoaded) {
                setState(() {
                  productCategories = state.categories.data.categories
                      .map((cat) => cat.category)
                      .toList();
                });
              }
            },
          ),
          BlocListener<MyProductsBloc, MyProductsState>(
            listener: (context, state) {
              if (state is BrandTypeMaterialLoaded) {
                setState(() {
                  brands = state.brands;
                  types = state.types;
                  materials = state.materials;
                  sizes = state.sizes;
                });

                // If we're in edit mode and have product data, populate the names
                if (_isEditMode && _editProductData != null) {
                  _populateNamesFromLoadedData(_editProductData!);
                } else if (_isEditMode && widget.productToEdit != null) {
                  _populateNamesFromLoadedData(widget.productToEdit!);
                }
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Product Image *',
                        style: AppTextStyles.base.w500.s14.primaryTextColor(),
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: Container(
                          width: 205.w,
                          height: 121.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: _buildImageContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                SearchableDropdown<String>(
                  label: 'Product category *',
                  hintText: 'Select category',
                  value: selectedCategoryName,
                  options: productCategories,
                  onChanged: (val) {
                    _onCategoryChanged(val);
                  },
                  displayValue: (val) => val,
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  'Name of product',
                  nameController,
                  hint: 'Enter name',
                ),
                SizedBox(height: 16.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Brand',
                            style: AppTextStyles.base.w500.s14
                                .primaryTextColor(),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: AppTextStyles.base.w500.s14.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: _showAddBrandDialog,
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Brand",
                                  style: AppTextStyles.base.w500.s13.l2
                                      .primaryTextColor()
                                      .medium,
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.add_box_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SearchableDropdown<Map<String, dynamic>>(
                      label: '',
                      isLabelVisible: false,
                      hintText: 'Select Brand',
                      value: brands.isNotEmpty && selectedBrand != null
                          ? brands.firstWhere(
                              (b) => b['name'] == selectedBrand,
                              orElse: () => <String, Object>{
                                'id': '',
                                'name': '',
                              },
                            )
                          : null,
                      options: brands,
                      onChanged: (val) {
                        setState(() {
                          selectedBrand = val?['name'];
                          selectedBrandId = val != null && val['id'] != null
                              ? val['id'].toString()
                              : null;
                        });
                      },
                      displayValue: (val) => val['name'] ?? '',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                SearchableDropdown<Map<String, dynamic>>(
                  label: 'Size *',
                  hintText: 'Select size',
                  value: sizes.isNotEmpty && selectedSize != null
                      ? sizes.firstWhere(
                          (s) => s['name'] == selectedSize,
                          orElse: () => <String, Object>{'id': '', 'name': ''},
                        )
                      : null,
                  options: sizes,
                  onChanged: (val) {
                    setState(() {
                      selectedSize = val?['name'];
                      selectedSizeId = val != null && val['id'] != null
                          ? val['id'].toString()
                          : null;
                    });
                  },
                  displayValue: (val) => val['name'] ?? '',
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  'Quantity',
                  quantityController,
                  hint: 'Enter quantity',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),

                SearchableDropdown<Map<String, dynamic>>(
                  label: 'Item Type *',
                  hintText: 'Select type',
                  value: types.isNotEmpty && selectedType != null
                      ? types.firstWhere(
                          (t) => t['name'] == selectedType,
                          orElse: () => <String, Object>{'id': '', 'name': ''},
                        )
                      : null,
                  options: types,
                  onChanged: (val) {
                    setState(() {
                      selectedType = val?['name'];
                      selectedTypeId = val != null && val['id'] != null
                          ? val['id'].toString()
                          : null;
                    });
                  },
                  displayValue: (val) => val['name'] ?? '',
                ),
                SizedBox(height: 16.h),

                SearchableDropdown<Map<String, dynamic>>(
                  label: 'Material Type *',
                  hintText: 'Select material',
                  value: materials.isNotEmpty && selectedMaterial != null
                      ? materials.firstWhere(
                          (m) => m['name'] == selectedMaterial,
                          orElse: () => <String, Object>{'id': '', 'name': ''},
                        )
                      : null,
                  options: materials,
                  onChanged: (val) {
                    setState(() {
                      selectedMaterial = val?['name'];
                      selectedMaterialId = val != null && val['id'] != null
                          ? val['id'].toString()
                          : null;
                    });
                  },
                  displayValue: (val) => val['name'] ?? '',
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  'Description',
                  descriptionController,
                  hint: 'Enter product description',
                  maxLines: 2,
                ),
                SizedBox(height: 16.h),

                BlocBuilder<MyProductsBloc, MyProductsState>(
                  builder: (context, state) {
                    final isLoading =
                        state is MyProductsLoading &&
                        (state.loadingType ==
                                MyProductsLoadingType.addingProduct ||
                            state.loadingType ==
                                MyProductsLoadingType.updatingProduct);

                    return AppButton.primary(
                      text: isLoading
                          ? (_isEditMode
                                ? 'Updating product...'
                                : 'Adding product...')
                          : (_isEditMode ? 'Update product' : 'Add product'),
                      onPressed: isLoading ? null : _handleAddProduct,
                    );
                  },
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppTextStyles.base.w500.s14.labelColor(),
            children: label == 'Description'
                ? []
                : [
                    TextSpan(
                      text: ' *',
                      style: AppTextStyles.base.w500.s14.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.base.s14.greyTextColor(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
          ),
        ),
      ],
    );
  }
}
