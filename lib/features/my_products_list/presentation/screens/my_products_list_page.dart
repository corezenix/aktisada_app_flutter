import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/my_products_list/data/models/my_product_filter_model.dart';
import 'package:aktisada/features/my_products_list/presentation/bloc/my_products_bloc.dart';
import 'package:aktisada/features/my_products_list/presentation/screens/add_product_page.dart';
import 'package:aktisada/features/my_products_list/presentation/screens/my_products_filter_page.dart';
import 'package:aktisada/features/my_products_list/presentation/screens/widgets/action_bottom_sheet.dart';
import 'package:aktisada/shared/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../product/presentation/screens/widgets/product_details_bottom_sheet.dart';
import '../bloc/my_products_event.dart';
import '../bloc/my_products_state.dart';

class MyProductsList extends StatefulWidget {
  const MyProductsList({super.key});

  @override
  State<MyProductsList> createState() => _MyProductsListState();
}

class _MyProductsListState extends State<MyProductsList> {
  final TextEditingController _searchController = TextEditingController();
  MyProductFilterModel? _currentFilters;

  @override
  void initState() {
    super.initState();
    context.read<MyProductsBloc>().add(LoadMyProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<MyProductsBloc>().add(LoadMyProducts());
    } else {
      context.read<MyProductsBloc>().add(SearchMyProducts(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("My Products", style: AppTextStyles.base.w700.s16),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          InkWell(
            onTap: () => NavigationHelper.push(context, const AddProductPage()),
            child: Container(
              height: 33,
              margin: const EdgeInsets.only(right: 21),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xffCDD7E4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Product",
                    style: AppTextStyles.base.w500.s13.l2.primaryColor().medium,
                  ),
                  SizedBox(width: 3.w),
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
      body: BlocListener<MyProductsBloc, MyProductsState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Reload products after adding
            context.read<MyProductsBloc>().add(LoadMyProducts());
          } else if (state is DeleteProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Reload products after deletion
            context.read<MyProductsBloc>().add(LoadMyProducts());
          } else if (state is MyProductsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Search and Filter Row
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      hintText: "Search my products...",
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      debounceTime: const Duration(milliseconds: 500),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  if (_currentFilters != null && _currentFilters!.hasFilters)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _currentFilters = null;
                        });
                        context.read<MyProductsBloc>().add(LoadMyProducts());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Filters cleared'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                      child: Text(
                        'Clear',
                        style: AppTextStyles.base.w500.s12.primaryTextColor(),
                      ),
                    ),
                  IconButton(
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.filter_list_rounded,
                          color:
                              (_currentFilters != null &&
                                  _currentFilters!.hasFilters)
                              ? AppColors.primary
                              : null,
                        ),
                        if (_currentFilters != null &&
                            _currentFilters!.hasFilters)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () async {
                      final bloc = context.read<MyProductsBloc>();
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProductsFilterPage(
                            currentFilters: _currentFilters,
                          ),
                        ),
                      );
                      // If filters were applied, update state and refresh the product list
                      if (result != null &&
                          result is Map<String, dynamic> &&
                          mounted) {
                        // Convert the API filters back to filter model for display
                        final filterModel = MyProductFilterModel(
                          category:
                              result['category_name'] ?? result['category_id'],
                          brand: result['brand_name'] ?? result['brand_id'],
                          size: result['item_size'],
                          type: result['type_name'] ?? result['type_id'],
                          material:
                              result['material_name'] ?? result['material_id'],
                          searchQuery: result['search'],
                        );

                        setState(() {
                          _currentFilters = filterModel;
                        });

                        bloc.add(LoadMyProductsWithFilters(filters: result));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              BlocBuilder<MyProductsBloc, MyProductsState>(
                builder: (context, state) {
                  if (state is MyProductsInitial) {
                    // Load products when in initial state
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        context.read<MyProductsBloc>().add(LoadMyProducts());
                      }
                    });
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is MyProductsLoading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is MyProductsLoaded) {
                    if (state.products.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 80.sp,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                state.searchQuery != null &&
                                        state.searchQuery!.isNotEmpty
                                    ? 'No products found for "${state.searchQuery}"'
                                    : 'No products found',
                                style: AppTextStyles.base.w500.s18.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              if (state.searchQuery == null ||
                                  state.searchQuery!.isEmpty) ...[
                                Text(
                                  'Start by adding your first product',
                                  style: AppTextStyles.base.w400.s14.copyWith(
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24.h),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddProductPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 12.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  icon: Icon(Icons.add, size: 20.sp),
                                  label: Text(
                                    'Add Product',
                                    style: AppTextStyles.base.w500.s14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.products.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.r),
                                  ),
                                ),
                                builder: (_) => BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, authState) {
                                    Map<String, dynamic>? userData;
                                    if (authState is UserLoaded) {
                                      userData = authState.userData;
                                    }

                                    // Debug logging
                                    debugPrint(
                                      '🔍 MyProductsListPage: Opening bottom sheet for product: ${product.name}',
                                    );
                                    debugPrint(
                                      '🔍 MyProductsListPage: Product imagePath: "${product.imagePath}"',
                                    );

                                    return ProductDetailsBottomSheet(
                                      productName: product.name,
                                      imageUrl: product.imagePath ?? '',
                                      brand: product.brandName ?? "",
                                      productType: product.typeName ?? "",
                                      availableUnits: product.displayQuantity,
                                      shopName: product.shopName ?? 'N/A',
                                      location: product.userLocation ?? 'N/A',
                                      contactPerson:
                                          product.userContactPerson ?? 'N/A',
                                      district: product.userDistrict ?? 'N/A',
                                      mobileNumber: product.userMobile ?? '',
                                      size: product.itemSize ?? '',
                                      materialType:
                                          product.materialName ?? 'N/A',
                                      description: product.description ?? '',
                                      userData: userData,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF0F6FD),
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: _buildProductImage(
                                            product.imagePath,
                                            width: 137.w,
                                            height: 97.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              child: Text(
                                                product.name,
                                                style: AppTextStyles
                                                    .base
                                                    .w600
                                                    .s14
                                                    .l2,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            _TextWidget(
                                              title: "Brand",
                                              description:
                                                  product.brandName ?? "",
                                            ),
                                            _TextWidget(
                                              title: "Size",
                                              description:
                                                  product.itemSize ?? "",
                                            ),
                                            _TextWidget(
                                              title: "Type",
                                              description:
                                                  product.typeName ?? "",
                                            ),
                                            _TextWidget(
                                              title: "Available",
                                              description:
                                                  product.displayQuantity,
                                            ),
                                            // if (product.)
                                            //   _TextWidget(
                                            //     title: "Price",
                                            //     description:
                                            //         product.displayPrice,
                                            //   ),
                                          ],
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          showActionSheet(context, product);
                                        },
                                        child: const Icon(Icons.more_vert),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is MyProductsFailure) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64.sp,
                              color: Colors.red,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Failed to load products',
                              style: AppTextStyles.base.w500.s16.copyWith(
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MyProductsBloc>().add(
                                  LoadMyProducts(),
                                );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 80.sp,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No products available',
                            style: AppTextStyles.base.w500.s18.copyWith(
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Start by adding your first product',
                            style: AppTextStyles.base.w400.s14.copyWith(
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddProductPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            icon: Icon(Icons.add, size: 20.sp),
                            label: Text(
                              'Add Product',
                              style: AppTextStyles.base.w500.s14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(
    String? imagePath, {
    double? width,
    double? height,
  }) {
    // Debug logging
    debugPrint('🔍 MyProductsListPage: Building image for path: "$imagePath"');

    // If imagePath is null, empty, or just whitespace, use fallback
    if (imagePath == null || imagePath.trim().isEmpty) {
      debugPrint(
        '⚠️ MyProductsListPage: Image path is null or empty, using fallback',
      );
      return Image.asset(
        AppAssets.images.floorTiles,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }

    // If imagePath starts with http or https, it's a network image
    if (imagePath.trim().toLowerCase().startsWith('http')) {
      debugPrint('🌐 MyProductsListPage: Loading network image: $imagePath');
      return Image.network(
        imagePath.trim(),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppAssets.images.floorTiles,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    // Otherwise, treat it as an asset path
    return Image.asset(
      imagePath.trim(),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppAssets.images.floorTiles,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title :", style: AppTextStyles.base.w400.s11.l2),
        Text(description, style: AppTextStyles.base.w500.s12.l2),
      ],
    );
  }
}
