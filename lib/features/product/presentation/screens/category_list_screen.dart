import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../data/models/category_model.dart';
import '../bloc/product_bloc.dart';
import 'product_detail_screen.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    setState(() {
      _isLoading = true;
    });
    context.read<ProductBloc>().add(GetCategoriesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Product Categories", style: AppTextStyles.base.w700.s16.l1),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            setState(() {
              _categories = state.categories.data.categories;
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 130,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  final category = _categories[index];
                  return InkWell(
                    onTap: () {
                      NavigationHelper.push(
                        context,
                        ProductDetailPage(
                          categoryId: category.id.toString(),
                          categoryName: category.category,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: category.imagePath != null
                              ? NetworkImage(category.imagePath!)
                              : const AssetImage(
                                  'assets/images/wall_tiles.png',
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
