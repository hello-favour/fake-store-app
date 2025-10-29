import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  double get totalPrice => product.price * quantity;

  CartItemModel copyWith({ProductModel? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
