import 'package:flutter/material.dart';
import 'package:strapi_food_app/constants.dart';
import 'package:strapi_food_app/domain/menu.dart';
import 'package:strapi_food_app/widgets/menu_image.dart';

class ItemDetails extends StatelessWidget {
  final MenuItemData item;

  const ItemDetails({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var photoUrl = PhotoUrl.largestImg(item.photo);

    return ListView(
      children: [
        if (photoUrl != null) MenuImage(itemId: item.id, photoUrl: photoUrl),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            item.name,
            style: theme.textTheme.headlineLarge,
          ),
        ),
        if (item.description != null)
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Text(
              item.description!,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ..._buildDetails(theme)
      ],
    );
  }

  List<Widget> _buildDetails(ThemeData theme) {
    var isOk = item.details != null && item.details.runtimeType == List;

    if (!isOk) return [];

    return item.details!
        .map((d) => Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4, color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      d["key"],
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      d["value"],
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
