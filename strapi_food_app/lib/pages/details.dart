import 'package:flutter/material.dart';
import 'package:strapi_food_app/repositories/menu_items.dart';
import 'package:strapi_food_app/widgets/menu_item_details.dart';

import '../domain/menu.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  // This is to show hero animation while the widget is loading
  // feel free to ignore it
  //
  // or read more: https://docs.flutter.dev/cookbook/navigation/hero-animations
  final String? initialPhotoUrl;

  const DetailsPage({required this.id, this.initialPhotoUrl, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MenuItemData? _item;

  @override
  void initState() {
    super.initState();

    // this is to show an image with initial photo url
    // feel free to ignore it
    if (widget.initialPhotoUrl != null) {
      _item = MenuItemData(
        id: widget.id,
        name: "",
        price: 0,
        photo: PhotoUrl(original: widget.initialPhotoUrl),
      );
    }

    _fetchData();
  }

  _fetchData() async {
    var item = await MenuItemsRepository.getMenuItem(widget.id);

    _item = item;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var item = _item;

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: Center(child: Text("Item ${widget.id} not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${item.name} details"),
      ),
      body: ItemDetails(item: item),
    );
  }
}
