import 'package:aktisada/core/utils/navigation_helper.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aktisada/features/auth/presentation/bloc/auth_state.dart';
import 'package:aktisada/features/auth/presentation/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../home/presentation/screens/home_page.dart';
import '../../../my_products_list/presentation/screens/my_products_list_page.dart';
import '../../../product/presentation/screens/category_list_screen.dart';
import '../../../profile/presentation/screens/profile_page.dart';
import 'widgets/bottom_nav_item_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage(onMenuTap: _openDrawer);
      case 1:
        return const CategoryListScreen();
      case 2:
        return const MyProductsList();
      default:
        return HomePage(onMenuTap: _openDrawer);
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green.shade700),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String shopName = 'Marble Gallery'; // Default fallback

                if (state is AuthSuccess) {
                  shopName = state.loginResponse.data.user.shopName;
                } else if (state is UserLoaded &&
                    state.userData['shop_name'] != null) {
                  shopName = state.userData['shop_name'];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      shopName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome to AKTSADA Calicut',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
              NavigationHelper.pushAndRemoveUntil(context, LoginPage());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      body: _getCurrentPage(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BottomNavItem(
                    image: _currentIndex == 0
                        ? 'assets/icons/home_selected.svg'
                        : 'assets/icons/home_unselected.svg',
                    label: 'Home',
                    isSelected: _currentIndex == 0,
                    onTap: () => _onTabChanged(0),
                  ),
                ),
                Expanded(
                  child: BottomNavItem(
                    image: _currentIndex == 1
                        ? 'assets/icons/product_selected.svg'
                        : 'assets/icons/product_unselected.svg',
                    label: 'Products',
                    isSelected: _currentIndex == 1,
                    onTap: () => _onTabChanged(1),
                  ),
                ),
                Expanded(
                  child: BottomNavItem(
                    image: _currentIndex == 2
                        ? 'assets/icons/my_products_selected.svg'
                        : 'assets/icons/my_products_unselected.svg',
                    label: 'My Products',
                    isSelected: _currentIndex == 2,
                    onTap: () => _onTabChanged(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
