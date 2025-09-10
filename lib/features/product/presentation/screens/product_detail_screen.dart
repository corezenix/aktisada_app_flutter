import 'dart:async';
import 'dart:developer';

import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/product/presentation/screens/product_filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';
import 'widgets/product_details_bottom_sheet.dart';

class ProductDetailPage extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;

  const ProductDetailPage({super.key, this.categoryId, this.categoryName});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<ProductModel> _products = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(() {
      setState(() {}); // Rebuild to show/hide clear button
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadProducts() {
    if (widget.categoryId != null) {
      setState(() {
        _isLoading = true;
      });

      final filters = {'category_id': widget.categoryId};
      context.read<ProductBloc>().add(GetProductListRequested(filters));
    }
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      // If search is cleared, load all products for the current category
      _loadProducts();
    } else {
      // Debounce search to avoid too many API calls
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        // Trigger search with the current category ID
        if (widget.categoryId != null) {
          context.read<ProductBloc>().add(
            SearchProducts(query, categoryId: widget.categoryId!),
          );
        }
      });
    }
  }

  Widget _buildProductListImage(
    String? imagePath, {
    double? width,
    double? height,
  }) {
    // If imagePath is null, empty, or just whitespace, use fallback
    if (imagePath == null || imagePath.trim().isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.image_not_supported,
          size: 32.sp,
          color: Colors.grey.shade600,
        ),
      );
    }

    // If imagePath starts with http or https, it's a network image
    if (imagePath.trim().toLowerCase().startsWith('http')) {
      return Image.network(
        imagePath.trim(),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          log('Failed to load network image: $imagePath, Error: $error');
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image,
                  size: 24.sp,
                  color: Colors.grey.shade600,
                ),
                if (height != null && height > 60) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Failed to Load',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
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
        log('Failed to load asset image: $imagePath, Error: $error');
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.image_not_supported,
            size: 32.sp,
            color: Colors.grey.shade600,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName ?? "Products",
          style: AppTextStyles.base.w700.s16,
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductListLoaded) {
            setState(() {
              _products = state.products.data;
              _isLoading = false;
            });
          } else if (state is ProductError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.white,
                        border: Border.all(color: Color(0xffCDD7E4)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: AppColors.grey),
                          hintText: "Search here",
                          border: InputBorder.none,
                          hintStyle: AppTextStyles.base.w400.s12.l1,
                          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                          isDense: true,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: AppColors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    _loadProducts();
                                  },
                                )
                              : null,
                        ),
                        onChanged: _onSearchChanged,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  IconButton(
                    icon: const Icon(Icons.filter_list_rounded),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(
                            categoryId: int.parse(widget.categoryId ?? '1'),
                            categoryName: widget.categoryName ?? 'Products',
                          ),
                        ),
                      );

                      // If filters were applied, refresh the product list
                      if (result != null && result is Map<String, dynamic>) {
                        setState(() {
                          _isLoading = true;
                        });
                        context.read<ProductBloc>().add(
                          GetProductListRequested(result),
                        );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _products.isEmpty
                    ? const Center(child: Text('No products available'))
                    : ListView.separated(
                        itemCount: _products.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final product = _products[index];
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
                                builder: (_) =>
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, authState) {
                                        Map<String, dynamic>? userData;
                                        if (authState is UserLoaded) {
                                          userData = authState.userData;
                                        }

                                        return ProductDetailsBottomSheet(
                                          productName: product.productTitle,
                                          imageUrl: product.imagePath ?? '',
                                          brand: product.brandName ?? 'N/A',
                                          productType:
                                              product.typeName ?? 'N/A',
                                          availableUnits:
                                              '${product.quantity} pieces',
                                          shopName:
                                              product.user?.shopName ??
                                              product.shopName ??
                                              'N/A',
                                          location:
                                              product.user?.location ?? 'N/A',
                                          contactPerson:
                                              product.user?.contactPerson ??
                                              'N/A',
                                          district:
                                              product.user?.district ?? 'N/A',
                                          mobileNumber:
                                              product.user?.mobile ??
                                              product.phoneNumber ??
                                              '',
                                          size: product.itemSize,
                                          materialType:
                                              product.materialName ?? 'N/A',
                                          description:
                                              product.description ?? '',
                                          userData: userData,
                                        );
                                      },
                                    ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF0F6FD)),
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
                                          child: _buildProductListImage(
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
                                            Text(
                                              product.productTitle,
                                              style: AppTextStyles
                                                  .base
                                                  .w600
                                                  .s14
                                                  .l2,
                                            ),
                                            SizedBox(height: 4.h),
                                            _TextWidget(
                                              title: "Brand",
                                              description:
                                                  product.brandName ?? 'N/A',
                                            ),
                                            _TextWidget(
                                              title: "Size",
                                              description: product.itemSize,
                                            ),
                                            _TextWidget(
                                              title: "Type",
                                              description:
                                                  product.typeName ?? 'N/A',
                                            ),
                                            _TextWidget(
                                              title: "Available",
                                              description:
                                                  '${product.quantity} pieces',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text.rich(
                                      TextSpan(
                                        style: AppTextStyles.base.s12.w400.l2,
                                        text: "Available at: ",
                                        children: [
                                          TextSpan(
                                            text:
                                                product.user?.shopName ??
                                                product.shopName ??
                                                'N/A',
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              letterSpacing: -0.2.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
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
        Text(description, style: AppTextStyles.base.w400.s12.l2),
      ],
    );
  }
}
