import 'package:flutter/material.dart';
import 'package:strapi_food_app/repositories/menu_items.dart';

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
    );
  }
}
