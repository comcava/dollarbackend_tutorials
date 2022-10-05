import 'package:dio/dio.dart';
import 'package:strapi_food_app/constants.dart';

import '../domain/menu.dart';

class MenuItemsRepository {
  static Future<List<MenuItemData>> getMenuItems() async {
    var dio = Dio();

    var response = await dio.get(
      '$kServerUrl/api/menu-items',
      options: Options(
        headers: {'Authorization': 'Bearer $kApiToken'},
      ),
      queryParameters: {"populate": "photo"},
    );

    var data = response.data["data"];

    var items = MenuItemData.fromStrapiList(data);

    return items;
  }
}
