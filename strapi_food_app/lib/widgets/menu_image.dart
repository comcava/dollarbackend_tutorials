import 'package:flutter/material.dart';

class MenuImage extends StatelessWidget {
  final String photoUrl;
  final int itemId;

  const MenuImage({
    required this.itemId,
    required this.photoUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "menuItem$itemId",
      child: Image.network(
        photoUrl,
        fit: BoxFit.cover,
        semanticLabel: "$itemId's photo",
      ),
    );
  }
}
