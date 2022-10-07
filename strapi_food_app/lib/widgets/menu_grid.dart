import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import '../domain/menu.dart';
import '../constants.dart';
import '../router.gr.dart';
import 'menu_image.dart';

final kGradient = LinearGradient(
  colors: [
    Colors.purple.shade200,
    Colors.purple.shade600,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
);

class MenuGrid extends StatelessWidget {
  final List<MenuItemData> items;

  const MenuGrid({
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        children: items
            .map((e) => ItemWidget(
                  menuItem: e,
                ))
            .toList(),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final MenuItemData menuItem;

  const ItemWidget({
    required this.menuItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget gradientOverlay;

    var photoUrl = PhotoUrl.largestImg(menuItem.photo);

    if (photoUrl == null) {
      gradientOverlay = DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.secondary,
            ),
            gradient: kGradient),
      );
    } else {
      gradientOverlay = ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.black87,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: MenuImage(
          itemId: menuItem.id,
          photoUrl: photoUrl,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(DetailsRoute(
          id: menuItem.id,
          initialPhotoUrl: photoUrl,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          gradient: kGradient,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SizedBox.expand(child: gradientOverlay),
            SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      menuItem.name,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kSmallPadding),
                    Text(
                      "\$ ${menuItem.price}  ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
  }
}
