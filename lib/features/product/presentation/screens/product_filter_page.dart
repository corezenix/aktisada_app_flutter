import 'dart:developer';

import 'package:aktisada/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_button.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/searchable_dropdown.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/brand_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/material_model.dart';
import '../../data/models/size_model.dart';
import '../../data/models/type_model.dart';
import '../bloc/product_bloc.dart';

class FilterPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const FilterPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Selected values - keeping the same UI structure
  String? selectedCategory;
  String? selectedBrand;
  String? selectedType;
  String? selectedShop;
  String? selectedSize;
  String? selectedMaterial;

  // API data for dropdowns
  List<CategoryModel> categories = [];
  List<BrandModel> brands = [];
  List<TypeModel> types = [];
  List<UserModel> shops = [];
  List<MaterialModel> materials = [];
  List<SizeModel> sizes = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set initial category based on passed categoryId
    _loadFilters();
  }

  void _loadFilters() {
    // Don't show loading initially - show UI immediately
    // Load filters based on the category ID passed to this page
    context.read<ProductBloc>().add(GetFiltersRequested(widget.categoryId));
  }

  void _loadFiltersForCategory(int categoryId) {
    // Load filters based on selected category
    context.read<ProductBloc>().add(GetFiltersRequested(categoryId));
  }

  void _applyFilters() {
    // Convert UI selections to API filter format
    final filters = <String, dynamic>{
      'category_id': widget.categoryId.toString(),
      'brand_id': selectedBrand != null
          ? brands.firstWhere((b) => b.brandName == selectedBrand).id.toString()
          : '',
      'type_id': selectedType != null
          ? types.firstWhere((t) => t.typeName == selectedType).id.toString()
          : '',
      'material_id': selectedMaterial != null
          ? materials
                .firstWhere((m) => m.materialName == selectedMaterial)
                .id
                .toString()
          : '',
      'user_id': selectedShop != null
          ? shops.firstWhere((s) => s.shopName == selectedShop).id.toString()
          : '',
      'item_size_id': selectedSize != null
          ? sizes.firstWhere((s) => s.itemSize == selectedSize).id.toString()
          : '',
    };

    // Remove empty values
    filters.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    log(
      "Filters applied: Category: $selectedCategory, Brand: $selectedBrand, Type: $selectedType, Shop: $selectedShop, Size: $selectedSize, Material: $selectedMaterial",
    );

    // Return the filters to the previous screen
    Navigator.pop(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppStrings.filter.title} - ${widget.categoryName}',
          style: AppTextStyles.base.w700.s16.l1,
        ),
        centerTitle: false,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is FiltersLoaded) {
            setState(() {
              categories = state.filters.data.categories;
              brands = state.filters.data.brands;
              types = state.filters.data.types;
              materials = state.filters.data.materials;
              shops = state.filters.data.shops;
              sizes = state.filters.data.sizes;
              isLoading = false;

              // Automatically set the category based on passed categoryId
              final categoryModel = categories.firstWhere(
                (cat) => cat.id == widget.categoryId,
                orElse: () => categories.first,
              );
              selectedCategory = categoryModel.category;

              // Reset other filter selections when new filters are loaded
              selectedBrand = null;
              selectedType = null;
              selectedShop = null;
              selectedSize = null;
              selectedMaterial = null;
            });
          } else if (state is ProductError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.w),
                child: ListView(
                  children: [
                    // Keep the exact same UI structure
                    SearchableDropdown<String>(
                      label: AppStrings.filter.productCategory,
                      hintText: AppStrings.filter.productCategoryHint,
                      value: selectedCategory,
                      options: categories.map((cat) => cat.category).toList(),
                      onChanged: (val) {
                        // Load filters for selected category
                        if (val != null) {
                          final selectedCategoryModel = categories.firstWhere(
                            (cat) => cat.category == val,
                          );

                          // Call Bloc to handle category change and filter loading
                          context.read<ProductBloc>().add(
                            GetFiltersRequested(selectedCategoryModel.id),
                          );
                        }
                      },
                      displayValue: (val) => val ?? '',
                    ),
                    SizedBox(height: 16.h),

                    SearchableDropdown<String>(
                      label: AppStrings.filter.brand,
                      hintText: brands.isEmpty
                          ? 'Select category first'
                          : AppStrings.filter.brandHint,
                      value: selectedBrand,
                      options: brands.isEmpty
                          ? ['Select category first']
                          : brands.map((brand) => brand.brandName).toList(),
                      onChanged: (val) {
                        if (brands.isNotEmpty) {
                          setState(() => selectedBrand = val);
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    SearchableDropdown<String>(
                      label: AppStrings.filter.typeFinish,
                      hintText: types.isEmpty
                          ? 'Select category first'
                          : AppStrings.filter.typeFinishHint,
                      value: selectedType,
                      options: types.isEmpty
                          ? ['Select category first']
                          : types.map((type) => type.typeName).toList(),
                      onChanged: (val) {
                        if (types.isNotEmpty) {
                          setState(() => selectedType = val);
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    SearchableDropdown<String>(
                      label: AppStrings.filter.shop,
                      hintText: shops.isEmpty
                          ? 'Select category first'
                          : AppStrings.filter.shopHint,
                      value: selectedShop,
                      options: shops.isEmpty
                          ? ['Select category first']
                          : shops.map((shop) => shop.shopName).toList(),
                      onChanged: (val) {
                        if (shops.isNotEmpty) {
                          setState(() => selectedShop = val);
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    SearchableDropdown<String>(
                      label: AppStrings.filter.size,
                      hintText: sizes.isEmpty
                          ? 'Select category first'
                          : AppStrings.filter.sizeHint,
                      value: selectedSize,
                      options: sizes.isEmpty
                          ? ['Select category first']
                          : sizes.map((size) => size.itemSize).toList(),
                      onChanged: (val) {
                        if (sizes.isNotEmpty) {
                          setState(() => selectedSize = val);
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    SearchableDropdown<String>(
                      label: AppStrings.filter.material,
                      hintText: materials.isEmpty
                          ? 'Select category first'
                          : AppStrings.filter.materialHint,
                      value: selectedMaterial,
                      options: materials.isEmpty
                          ? ['Select category first']
                          : materials
                                .map((material) => material.materialName)
                                .toList(),
                      onChanged: (val) {
                        if (materials.isNotEmpty) {
                          setState(() => selectedMaterial = val);
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 32.h),

                    AppButton.primary(
                      text: 'Apply filter',
                      onPressed: _applyFilters,
                    ),
                    SizedBox(height: 16.h),

                    // Show active filters indicator
                    if (_hasActiveFilters())
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  color: Colors.blue,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Active Filters:',
                                  style: AppTextStyles.base.w600.s14.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 4.h,
                              children: [
                                if (selectedCategory != null)
                                  _buildFilterChip(
                                    'Category: $selectedCategory',
                                  ),
                                if (selectedBrand != null)
                                  _buildFilterChip('Brand: $selectedBrand'),
                                if (selectedType != null)
                                  _buildFilterChip('Type: $selectedType'),
                                if (selectedShop != null)
                                  _buildFilterChip('Shop: $selectedShop'),
                                if (selectedSize != null)
                                  _buildFilterChip('Size: $selectedSize'),
                                if (selectedMaterial != null)
                                  _buildFilterChip(
                                    'Material: $selectedMaterial',
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedCategory != null ||
        selectedBrand != null ||
        selectedType != null ||
        selectedShop != null ||
        selectedSize != null ||
        selectedMaterial != null;
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.base.w500.s12.copyWith(
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}
