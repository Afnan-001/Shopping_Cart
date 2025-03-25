import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart/models/cart_item_model.dart';
import 'package:shopping_cart/providers/cart_provider.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: SizedBox(
        width: 50, // Adjust image size
        height: 50,
        child: Image.network(
          item.product.images.first,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        ),
      ),
      title: Text(item.product.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quantity: ${item.quantity}'),
          Text(
            NumberFormat.currency(symbol: '¥').format(item.product.discountedPrice),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => ref.read(cartProvider.notifier)
              .updateQuantity(item.product.id, item.quantity - 1),
          ),
          Text(item.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ref.read(cartProvider.notifier)
              .updateQuantity(item.product.id, item.quantity + 1),
          ),
        ],
      ),
    );
  }
}
