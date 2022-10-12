import 'package:flutter/foundation.dart';

import '../constants.dart';

class MenuItemData {
  int id;
  String name;
  PhotoUrl? photo;
  double price;

  String? description;
  List? details;

  MenuItemData({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.details,
    this.photo,
  });

  /// Create a list of [MenuItemData] from strapi's response
  static List<MenuItemData> fromStrapiList(dynamic data) {
    List<MenuItemData> items = List.empty(growable: true);

    for (var d in data) {
      try {
        var attrs = d["attributes"];
        // dart doesn't like when we're trying to parse '10'
        var price = double.parse(attrs["price"].toString());

        var item = MenuItemData(
          id: d["id"],
          name: attrs["name"],
          price: price,
          description: attrs["description"],
          details: attrs["details"],
        );

        var photo = attrs["photo"]?["data"];

        if (photo != null) {
          var url = photo["attributes"]["url"];
          // strapi returns relative urls, like '/uploads/coffee.jpg'
          item.photo = PhotoUrl(original: "$kServerUrl$url");

          var formats = photo["attributes"]["formats"];

          if (formats != null) {
            var small = formats["small"]["url"];

            item.photo?.small = "$kServerUrl$small";
          }
        }

        items.add(item);
      } catch (e) {
        debugPrint("Error deserializing menuItem from Strapi: $e");
        continue;
      }
    }

    return items;
  }
}

class PhotoUrl {
  String? original;
  String? small;

  PhotoUrl({
    this.original,
    this.small,
  });

  static String? largestImg(PhotoUrl? url) {
    if (url == null) {
      return null;
    }

    return url.original ?? url.small;
  }
}
