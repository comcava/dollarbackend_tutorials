import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../repositories/menu_items.dart';
import '../router.gr.dart';

import '../widgets/menu_grid.dart';
import '../domain/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuItemData> _items = [];

  @override
  void initState() {
    super.initState();

    _fetchMenuItems();
  }

  Future<void> _fetchMenuItems() async {
    var items = await MenuItemsRepository.getMenuItems();
    _items = items;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food app"),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchMenuItems,
        child: MenuGrid(items: _items),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const OrderRoute());
        },
        tooltip: "Order",
        backgroundColor: kOrderButtonBgColor,
        foregroundColor: kOrderButtonFgColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
