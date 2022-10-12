import 'package:dio/dio.dart';

import '../constants.dart';
import '../domain/menu.dart';

class MenuItemsRepository {
  static Future<List<MenuItemData>> getMenuItems() async {
    var dio = Dio();

    var response = await dio.get(
      '$kServerUrl/api/menu-items',
      options: Options(
        headers: {'Authorization': 'Bearer $kApiToken'},
      ),
      queryParameters: {
        "populate": "photo",
        "fields": ["name", "price"]
      },
    );

    var data = response.data["data"];

    var items = MenuItemData.fromStrapiList(data);

    return items;
  }

  static Future<MenuItemData?> getMenuItem(int id) async {
    var dio = Dio();

    var response = await dio.get(
      '$kServerUrl/api/menu-items/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $kApiToken'},
      ),
      queryParameters: {"populate": "photo"},
    );

    var data = response.data["data"];

    var items = MenuItemData.fromStrapiList([data]);

    if (items.isNotEmpty) {
      return items.first;
    }

    return null;
  }

  static Future<void> createOrder({
    required String name,
    required String phone,
    required List<MenuItemData> menuItems,
  }) async {
    var data = menuItems
        .map(
          (i) => {
            "id": i.id,
            "name": i.name,
            "price": i.price,
          },
        )
        .toList();

    var dio = Dio();

    await dio.post(
      '$kServerUrl/api/orders',
      data: {
        "data": {
          "name": name,
          "phone": phone,
          "data": data,
        }
      },
      options: Options(
        headers: {'Authorization': 'Bearer $kApiToken'},
        contentType: "application/json",
      ),
    );
  }
}
