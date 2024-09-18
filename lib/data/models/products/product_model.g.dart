// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

_$ProductElementImpl _$$ProductElementImplFromJson(Map<String, dynamic> json) =>
    _$ProductElementImpl(
      name: json['name'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      statusId: (json['statusId'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: json['unitPrice'] as String?,
      purchaseDate: json['purchaseDate'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      purchasePlace: json['purchasePlace'] as String?,
      brand: json['brand'] as String?,
      additionalNotes: json['additionalNotes'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$ProductElementImplToJson(
        _$ProductElementImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'statusId': instance.statusId,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'purchaseDate': instance.purchaseDate,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'purchasePlace': instance.purchasePlace,
      'brand': instance.brand,
      'additionalNotes': instance.additionalNotes,
      'image': instance.image,
    };
