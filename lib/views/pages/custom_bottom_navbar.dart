import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/views/pages/cart_page.dart';
import 'package:ecommerce_app/views/pages/favourites_page.dart';
import 'package:ecommerce_app/views/pages/home_page.dart';
import 'package:ecommerce_app/views/pages/profilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/Syfer.jpg'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SaifNagy', style: Theme.of(context).textTheme.labelLarge),
            Text(
              'Lets\'s go shopping',
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          if (currentindex == 0) ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search),
            ),
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
          ] else if (currentindex == 1) ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.shopping_cart),
            ),
          ],
        ],
      ),
      body: PersistentTabView(
        backgroundColor: AppColors.white,
        tabs: [
          PersistentTabConfig(
            screen: const HomePage(),
            item: ItemConfig(
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey,

              icon: const Icon(CupertinoIcons.home),
              title: 'Home',
            ),
          ),
          PersistentTabConfig(
            screen: const CartPage(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.cart),
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey,
              title: 'Cart',
            ),
          ),
          PersistentTabConfig(
            screen: const FavouritesPage(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.heart),
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey,
              title: 'Favourites',
            ),
          ),
          PersistentTabConfig(
            screen: const ProfilePage(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.person),
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: AppColors.grey,
              title: 'Profile',
            ),
          ),
        ],
        stateManagement: false,
        onTabChanged: (index) {
          setState(() {
            currentindex = index;
          });
        },
        navBarBuilder:
            (navBarConfig) => Style6BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}