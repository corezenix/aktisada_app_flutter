import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_button.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../shared/widgets/searchable_dropdown.dart';
import '../../../product/data/models/brand_model.dart';
import '../../../product/data/models/category_model.dart';
import '../../../product/data/models/material_model.dart';
import '../../../product/data/models/size_model.dart';
import '../../../product/data/models/type_model.dart';
import '../../../product/presentation/bloc/product_bloc.dart';
import '../../../product/presentation/bloc/product_state.dart' as product_state;
import '../../data/models/my_product_filter_model.dart';

class MyProductsFilterPage extends StatefulWidget {
  final MyProductFilterModel? currentFilters;

  const MyProductsFilterPage({super.key, this.currentFilters});

  @override
  State<MyProductsFilterPage> createState() => _MyProductsFilterPageState();
}

class _MyProductsFilterPageState extends State<MyProductsFilterPage> {
  late MyProductFilterModel _filters;

  // Available filter options from API
  List<CategoryModel> _categories = [];
  List<BrandModel> _brands = [];
  List<SizeModel> _sizes = [];
  List<TypeModel> _types = [];
  List<MaterialModel> _materials = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters ?? const MyProductFilterModel();
    _loadFilterOptions();
    // Don't show loading initially - show categories immediately
    _isLoading = false;

    // If we have existing filters, load the corresponding data
    if (_filters.category != null) {
      _loadExistingFilters();
    }
  }

  void _loadExistingFilters() {
    if (_filters.category != null && _categories.isNotEmpty) {
      final selectedCategory = _categories.firstWhere(
        (cat) => cat.category == _filters.category,
        orElse: () => _categories.first,
      );
      context.read<ProductBloc>().add(GetFiltersRequested(selectedCategory.id));
    }
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

  void _loadFilterOptions() {
    // Load categories first - other filters will be loaded when category is selected
    context.read<ProductBloc>().add(GetCategoriesRequested());
  }

  void _loadFiltersForCategory(int categoryId) {
    // Show loading only when fetching filters for a category
    setState(() {
      _isLoading = true;
    });
    // Load filters based on selected category
    context.read<ProductBloc>().add(GetFiltersRequested(categoryId));
  }

  void _applyFilters() {
    // Get user ID from local storage
    final localStorageService = context.read<LocalStorageService>();
    final userId = localStorageService.getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not authenticated. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Convert UI selections to API filter format with IDs
    final apiFilters = <String, dynamic>{
      'user_id': userId.toString(),
      'category_id': _filters.category != null
          ? _categories
                .firstWhere((cat) => cat.category == _filters.category)
                .id
                .toString()
          : '',
      'brand_id': _filters.brand != null
          ? _brands
                .firstWhere((b) => b.brandName == _filters.brand)
                .id
                .toString()
          : '',
      'type_id': _filters.type != null
          ? _types.firstWhere((t) => t.typeName == _filters.type).id.toString()
          : '',
      'material_id': _filters.material != null
          ? _materials
                .firstWhere((m) => m.materialName == _filters.material)
                .id
                .toString()
          : '',
      'item_size': _filters.size ?? '',
      'search': _filters.searchQuery ?? '',
    };

    // Remove empty values
    apiFilters.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    log(
      "My Products Filters applied: Category: ${_filters.category}, Brand: ${_filters.brand}, Type: ${_filters.type}, Material: ${_filters.material}, Size: ${_filters.size}, Search: ${_filters.searchQuery}",
    );

    // Return the API-ready filters
    Navigator.pop(context, apiFilters);
  }

  void _clearFilters() {
    setState(() {
      _filters = const MyProductFilterModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter My Products',
          style: AppTextStyles.base.w700.s16.l1,
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _clearFilters,
            child: Text(
              'Clear',
              style: AppTextStyles.base.w500.s14.primaryTextColor(),
            ),
          ),
        ],
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            setState(() {
              _categories = state.categories.data.categories;
              // Clear other filters when categories are loaded
              _brands = [];
              _sizes = [];
              _types = [];
              _materials = [];
            });
          } else if (state is FiltersLoaded) {
            setState(() {
              _brands = state.filters.data.brands;
              _sizes = state.filters.data.sizes;
              _types = state.filters.data.types;
              _materials = state.filters.data.materials;
              _isLoading = false;

              // Only reset filters if this is a new category selection
              // Keep existing filter values if they were already set
              if (_filters.category != null &&
                  _filters.brand == null &&
                  _filters.type == null &&
                  _filters.material == null &&
                  _filters.size == null) {
                // This is initial load for existing filters, don't reset
              } else {
                // This is a new category selection, reset other filters
                _filters = _filters.copyWith(
                  brand: null,
                  type: null,
                  material: null,
                  size: null,
                );
              }
            });
          } else if (state is product_state.ProductFailure) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to load filter options: ${(state as product_state.ProductFailure).message}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // 1. Product category
                    SearchableDropdown<String>(
                      label: 'Product Category',
                      hintText: 'Select category',
                      value: _filters.category ?? 'All Categories',
                      options: [
                        'All Categories',
                        ..._categories.map((cat) => cat.category),
                      ],
                      onChanged: (val) {
                        // Load filters for selected category
                        if (val != 'All Categories' && val != null) {
                          final selectedCategory = _categories.firstWhere(
                            (cat) => cat.category == val,
                          );

                          // Call Bloc to handle category change and filter loading
                          context.read<ProductBloc>().add(
                            GetFiltersRequested(selectedCategory.id),
                          );
                        }
                      },
                      displayValue: (val) => val,
                    ),
                    SizedBox(height: 16.h),

                    // 2. Brand
                    SearchableDropdown<String>(
                      label: 'Brand',
                      hintText: _brands.isEmpty
                          ? 'Select category first'
                          : 'Select brand',
                      value:
                          _filters.brand ??
                          (_brands.isNotEmpty ? 'All Brands' : null),
                      options: _brands.isEmpty
                          ? ['Select category first']
                          : [
                              'All Brands',
                              ..._brands.map((brand) => brand.brandName),
                            ],
                      onChanged: (val) {
                        if (_brands.isNotEmpty) {
                          setState(() {
                            _filters = _filters.copyWith(
                              brand: val == 'All Brands' ? null : val,
                            );
                          });
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    // 3. Size
                    SearchableDropdown<String>(
                      label: 'Size',
                      hintText: _sizes.isEmpty
                          ? 'Select category first'
                          : 'Select size',
                      value:
                          _filters.size ??
                          (_sizes.isNotEmpty ? 'All Sizes' : null),
                      options: _sizes.isEmpty
                          ? ['Select category first']
                          : [
                              'All Sizes',
                              ..._sizes.map((size) => size.itemSize),
                            ],
                      onChanged: (val) {
                        if (_sizes.isNotEmpty) {
                          setState(() {
                            _filters = _filters.copyWith(
                              size: val == 'All Sizes' ? null : val,
                            );
                          });
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    // 4. Item type
                    SearchableDropdown<String>(
                      label: 'Item Type',
                      hintText: _types.isEmpty
                          ? 'Select category first'
                          : 'Select type',
                      value:
                          _filters.type ??
                          (_types.isNotEmpty ? 'All Types' : null),
                      options: _types.isEmpty
                          ? ['Select category first']
                          : [
                              'All Types',
                              ..._types.map((type) => type.typeName),
                            ],
                      onChanged: (val) {
                        if (_types.isNotEmpty) {
                          setState(() {
                            _filters = _filters.copyWith(
                              type: val == 'All Types' ? null : val,
                            );
                          });
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    // 5. Material type
                    SearchableDropdown<String>(
                      label: 'Material Type',
                      hintText: _materials.isEmpty
                          ? 'Select category first'
                          : 'Select material',
                      value:
                          _filters.material ??
                          (_materials.isNotEmpty ? 'All Materials' : null),
                      options: _materials.isEmpty
                          ? ['Select category first']
                          : [
                              'All Materials',
                              ..._materials.map(
                                (material) => material.materialName,
                              ),
                            ],
                      onChanged: (val) {
                        if (_materials.isNotEmpty) {
                          setState(() {
                            _filters = _filters.copyWith(
                              material: val == 'All Materials' ? null : val,
                            );
                          });
                        }
                      },
                      displayValue: (val) => val ?? 'Select category first',
                    ),
                    SizedBox(height: 16.h),

                    SizedBox(height: 32.h),

                    AppButton.primary(
                      text: 'Apply Filters',
                      onPressed: _applyFilters,
                    ),
                    SizedBox(height: 16.h),

                    // Show active filters indicator
                    if (_filters.hasFilters)
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
                                if (_filters.category != null)
                                  _buildFilterChip(
                                    'Category: ${_filters.category}',
                                  ),
                                if (_filters.brand != null)
                                  _buildFilterChip('Brand: ${_filters.brand}'),
                                if (_filters.size != null)
                                  _buildFilterChip('Size: ${_filters.size}'),
                                if (_filters.type != null)
                                  _buildFilterChip('Type: ${_filters.type}'),
                                if (_filters.material != null)
                                  _buildFilterChip(
                                    'Material: ${_filters.material}',
                                  ),
                                if (_filters.searchQuery != null &&
                                    _filters.searchQuery!.isNotEmpty)
                                  _buildFilterChip(
                                    'Search: ${_filters.searchQuery}',
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
