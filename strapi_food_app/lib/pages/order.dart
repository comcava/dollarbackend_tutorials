import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../repositories/cart.dart';
import '../repositories/menu_items.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _cartRepository = CartRepository();

  _createOrder(BuildContext context) async {
    var items = _cartRepository.items;
    if (items.isEmpty) {
      return;
    }

    Map namePhoneMap = await showDialog(
      context: context,
      builder: (context) => const _OrderAlert(),
    );

    String name = namePhoneMap["name"];
    String phone = namePhoneMap["phone"];

    await MenuItemsRepository.createOrder(
      name: name,
      phone: phone,
      menuItems: items,
    );

    _cartRepository.clear();

    await showDialog(
      context: context,
      builder: (context) => const _ThankYouDialog(),
    );

    if (mounted) {
      AutoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Place an order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text("Order", style: theme.textTheme.headlineMedium),
            ),
            const SizedBox(height: kDefaultPadding),
            ..._buildCart(theme),
            const SizedBox(height: kLargePadding),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () => _createOrder(context),
                icon: const Icon(Icons.shopping_bag),
                label: const Text("Order"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOrderButtonBgColor,
                  foregroundColor: kOrderButtonFgColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kLargePadding,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _cartRepository.clear();
                  });
                },
                style:
                    TextButton.styleFrom(foregroundColor: kOrderButtonBgColor),
                child: const Text("Clear cart"),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCart(ThemeData theme) {
    var items = _cartRepository.items;

    if (items.isEmpty) {
      return [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kLargePadding),
          child: Text(
            "No items in cart",
            style: theme.textTheme.headlineSmall,
          ),
        )
      ];
    }

    double total = 0;
    List<Widget> itemsList = [];

    itemsList.addAll(
      items.map((i) {
        total += i.price;

        return ListTile(
          leading: const Icon(Icons.restaurant),
          title: Text(i.name),
          subtitle: Text("\$ ${i.price}"),
        );
      }),
    );

    itemsList.add(
      Padding(
        padding: const EdgeInsets.all(kLargePadding),
        child: Text(
          "Total: \$ $total",
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );

    return itemsList;
  }
}

class _OrderAlert extends StatefulWidget {
  const _OrderAlert();

  @override
  State<_OrderAlert> createState() => _OrderAlertState();
}

class _OrderAlertState extends State<_OrderAlert> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _notEmptyValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return "Cannot be empty";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Your name"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              validator: _notEmptyValidator,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _phoneController,
              validator: _notEmptyValidator,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            var valid = _formKey.currentState!.validate();

            if (!valid) {
              return;
            }

            var name = _nameController.text;
            var phone = _phoneController.text;

            AutoRouter.of(context).pop(
              {"name": name, "phone": phone},
            );
          },
          child: const Text("Order"),
        )
      ],
    );
  }
}

class _ThankYouDialog extends StatelessWidget {
  const _ThankYouDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Thank you 🧀"),
      content: const Text(
        "Your order has been placed. We'll call you to confirm your order soon",
      ),
      actions: [
        TextButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          child: const Text("Ok"),
        )
      ],
    );
  }
}
