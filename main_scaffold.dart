// lib/screens/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/store_provider.dart';
import '../theme.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'account_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ShopScreen(initialCategory: 'purses'),
    const ShopScreen(initialCategory: 'weaves'),
    const WishlistScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void goToTab(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, store, _) {
        return Scaffold(
          backgroundColor: kBackground,
          drawer: _buildDrawer(context, store),
          appBar: AppBar(
            backgroundColor: kBackground.withOpacity(0.96),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: kBorder),
            ),
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: kForeground),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            title: Text('Purseonality',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: kPrimary,
                    fontStyle: FontStyle.italic)),
            centerTitle: true,
            actions: [
              Stack(children: [
                IconButton(
                    icon: Icon(
                        store.wishlist.isNotEmpty
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            store.wishlist.isNotEmpty ? kPrimary : kForeground),
                    onPressed: () => goToTab(3)),
                if (store.wishlist.isNotEmpty)
                  Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            color: kPrimary, shape: BoxShape.circle),
                        child: Center(
                            child: Text('${store.wishlist.length}',
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))),
                      )),
              ]),
              Stack(children: [
                IconButton(
                    icon: Icon(Icons.shopping_bag_outlined,
                        color: store.cartCount > 0 ? kPrimary : kForeground),
                    onPressed: () => goToTab(4)),
                if (store.cartCount > 0)
                  Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            color: kPrimary, shape: BoxShape.circle),
                        child: Center(
                            child: Text('${store.cartCount}',
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))),
                      )),
              ]),
              const SizedBox(width: 4),
            ],
          ),
          body: IndexedStack(index: _currentIndex, children: _screens),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: kCard,
              border: Border(top: BorderSide(color: kBorder)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 12,
                    offset: Offset(0, -2)),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: goToTab,
              backgroundColor: kCard,
              selectedItemColor: kPrimary,
              unselectedItemColor: kMutedFg,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    activeIcon: Icon(Icons.shopping_bag),
                    label: 'Purses'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.content_cut_outlined),
                    activeIcon: Icon(Icons.content_cut),
                    label: 'Weaves'),
                BottomNavigationBarItem(
                    icon: Icon(
                        store.wishlist.isNotEmpty
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: store.wishlist.isNotEmpty ? kPrimary : null),
                    activeIcon: const Icon(Icons.favorite),
                    label: 'Wishlist'),
                BottomNavigationBarItem(
                    icon: store.cartCount > 0
                        ? Badge(
                            label: Text('${store.cartCount}'),
                            child: const Icon(Icons.shopping_cart_outlined))
                        : const Icon(Icons.shopping_cart_outlined),
                    activeIcon: const Icon(Icons.shopping_cart),
                    label: 'Cart'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Account'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context, StoreProvider store) {
    final navItems = [
      {'icon': Icons.home_outlined, 'label': 'Home', 'index': 0},
      {'icon': Icons.shopping_bag_outlined, 'label': 'Shop Purses', 'index': 1},
      {'icon': Icons.content_cut_outlined, 'label': 'Shop Weaves', 'index': 2},
      {'icon': Icons.favorite_border, 'label': 'My Wishlist', 'index': 3},
      {
        'icon': Icons.shopping_cart_outlined,
        'label': 'Shopping Cart',
        'index': 4
      },
      {'icon': Icons.person_outline, 'label': 'My Account', 'index': 5},
    ];
    return Drawer(
      backgroundColor: kBackground,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 16),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kBorder))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Purseonality',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kPrimary,
                      fontStyle: FontStyle.italic)),
              IconButton(
                  icon: const Icon(Icons.close, color: kForeground),
                  onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: navItems.map((item) {
              final idx = item['index'] as int;
              final count = idx == 4
                  ? store.cartCount
                  : idx == 3
                      ? store.wishlist.length
                      : 0;
              return ListTile(
                leading:
                    Icon(item['icon'] as IconData, color: kPrimary, size: 22),
                title: Text(item['label'] as String,
                    style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kForeground)),
                trailing: count > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text('$count',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)))
                    : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  Navigator.pop(context);
                  goToTab(idx);
                },
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: kSecondary,
              border: Border(top: BorderSide(color: kBorder))),
          child: Text('Free shipping on all orders across SA',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 12, color: kMutedFg)),
        ),
      ]),
    );
  }
}
