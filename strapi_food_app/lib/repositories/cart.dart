import '../domain/menu.dart';

class CartRepository {
  // global singleton instance
  static final CartRepository _cart = CartRepository._create();

  // a list of items added to cart
  final List<MenuItemData> _items = List.empty(growable: true);

  // a getter for `_items`
  // we don't want to expose `_items` as a public variable,
  // to prevent people from changing it
  List<MenuItemData> get items => _items;

  // a factory for `CartRepository()` constructor
  //
  // creating a new instance using this factory
  // is like this:
  //  final _cartRepository = CartRepository();s
  factory CartRepository() {
    // have to return an existing instance to preserve
    // all the variables
    return CartRepository._cart;
  }

  // a private constructor. it could be called anything,
  // here it is called _create
  CartRepository._create();

  /// Add [MenuItemData] to [list]
  add(MenuItemData item) {
    _items.add(item);
  }

  /// Remove all [MenuItemData]s from the cart
  clear() {
    _items.clear();
  }
}
