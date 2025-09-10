import 'dart:developer';

import 'package:aktisada/core/constants/app_assets.dart';
import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/constants/app_strings.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:aktisada/core/constants/loading_status.dart';
import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/product/data/models/category_model.dart';
import 'package:aktisada/features/product/data/models/slide_model.dart';
import 'package:aktisada/features/product/presentation/bloc/product_bloc.dart';
import 'package:aktisada/features/product/presentation/screens/category_list_screen.dart';
import 'package:aktisada/features/product/presentation/screens/product_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onMenuTap;

  const HomePage({super.key, this.onMenuTap});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentBanner = 0;

  // API data
  List<SlideModel> _slides = [];
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Load slides and categories from API
    context.read<ProductBloc>().add(GetSlidesRequested());
    context.read<ProductBloc>().add(GetCategoriesRequested());
  }

  void _onCategoryTap(CategoryModel category) {
    NavigationHelper.push(
      context,
      ProductDetailPage(
        categoryId: category.id.toString(),
        categoryName: category.category,
      ),
    );
  }

  void _switchBottomNavTab(int index) {
    // This will be handled by the parent dashboard
    // For now, just navigate to category list
    NavigationHelper.push(context, CategoryListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SlidesLoaded) {
            setState(() => _slides = state.slides.slides);
          } else if (state is CategoriesLoaded) {
            setState(() => _categories = state.categories.data.categories);
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            // Check if we're in initial loading state (no data yet)
            final bool isLoading =
                state is ProductInitial ||
                state is ProductLoading ||
                state.status == LoadingStatus.loading ||
                (_slides.isEmpty && _categories.isEmpty);

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        height: 240.h,
                        color: Colors.green.shade700,
                        child: Column(
                          children: [
                            SizedBox(height: kToolbarHeight),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () {
                                    if (widget.onMenuTap != null) {
                                      widget.onMenuTap!();
                                    }
                                  },
                                ),
                                SizedBox(width: 12.w),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, authState) {
                                    String title = AppStrings
                                        .home
                                        .title; // Default fallback

                                    log(
                                      '🏠 Home Page - Auth State: ${authState.runtimeType}',
                                    );

                                    if (authState is AuthSuccess) {
                                      title = authState
                                          .loginResponse
                                          .data
                                          .user
                                          .shopName;
                                      log(
                                        '🏠 Home Page - Shop Name from AuthSuccess: $title',
                                      );
                                    } else if (authState is UserLoaded &&
                                        authState.userData['shop_name'] !=
                                            null) {
                                      title = authState.userData['shop_name'];
                                      log(
                                        '🏠 Home Page - Shop Name from UserLoaded: $title',
                                      );
                                    } else {
                                      log(
                                        '🏠 Home Page - Using default title: $title',
                                      );
                                    }

                                    return Text(
                                      title,
                                      style: AppTextStyles.base.w700.s16
                                          .whiteColor(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: kToolbarHeight + 80,
                        ),
                        child: isLoading
                            ? _buildLoadingCarousel()
                            : CarouselSlider(
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                  height: 180,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentBanner = index;
                                    });
                                  },
                                ),
                                items: _slides.isNotEmpty
                                    ? _slides.map((slide) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.network(
                                            slide.imagePath,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Image.asset(
                                                    AppAssets.images.banner1,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  );
                                                },
                                          ),
                                        );
                                      }).toList()
                                    : bannerImages.map((imagePath) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        );
                                      }).toList(),
                              ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  if (!isLoading)
                    AnimatedSmoothIndicator(
                      activeIndex: _currentBanner,
                      count: _slides.isNotEmpty
                          ? _slides.length
                          : bannerImages.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.green,
                      ),
                    ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => _switchBottomNavTab(1),
                              child: Text(
                                'See all',
                                style: AppTextStyles.base.w600.s14.blackColor(),
                              ),
                            ),
                          ],
                        ),
                        if (isLoading)
                          _buildLoadingCategories()
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 12.h),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _categories.isNotEmpty
                                ? _categories.length <= 4
                                      ? _categories.length
                                      : 4
                                : categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 130,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (_, index) {
                              if (_categories.isNotEmpty) {
                                // Use API data
                                final category = _categories[index];
                                return InkWell(
                                  onTap: () => _onCategoryTap(category),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: category.imagePath != null
                                            ? NetworkImage(category.imagePath!)
                                            : AssetImage(
                                                    AppAssets.images.wallTiles,
                                                  )
                                                  as ImageProvider,
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) {
                                          // Fallback to asset image
                                        },
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
                              } else {
                                // Use fallback data
                                final category = categories[index];
                                return InkWell(
                                  onTap: () {
                                    NavigationHelper.push(
                                      context,
                                      CategoryListScreen(),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: AssetImage(category['image']!),
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
                                          category['title']!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingCarousel() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade300,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
            ),
            SizedBox(height: 12.h),
            Text(
              'Loading banners...',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCategories() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 12.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 130,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green.shade700,
                  ),
                  strokeWidth: 2,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final List<String> bannerImages = [
  AppAssets.images.banner1,
  AppAssets.images.banner1,
];

final List<Map<String, String>> categories = [
  {'title': AppStrings.home.wallTiles, 'image': AppAssets.images.wallTiles},
  {'title': AppStrings.home.floorTiles, 'image': AppAssets.images.floorTiles},
  {'title': AppStrings.home.washBasins, 'image': AppAssets.images.washBasins},
  {
    'title': AppStrings.home.westernToilets,
    'image': AppAssets.images.westernToilets,
  },
];
