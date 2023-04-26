// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.cloud_formation.model.type_filters; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i3;
import 'package:smoke_test/src/sdk/src/cloud_formation/model/category.dart'
    as _i2;

part 'type_filters.g.dart';

/// Filter criteria to use in determining which extensions to return.
abstract class TypeFilters
    with _i1.AWSEquatable<TypeFilters>
    implements Built<TypeFilters, TypeFiltersBuilder> {
  /// Filter criteria to use in determining which extensions to return.
  factory TypeFilters({
    _i2.Category? category,
    String? publisherId,
    String? typeNamePrefix,
  }) {
    return _$TypeFilters._(
      category: category,
      publisherId: publisherId,
      typeNamePrefix: typeNamePrefix,
    );
  }

  /// Filter criteria to use in determining which extensions to return.
  factory TypeFilters.build([void Function(TypeFiltersBuilder) updates]) =
      _$TypeFilters;

  const TypeFilters._();

  static const List<_i3.SmithySerializer> serializers = [
    TypeFiltersAwsQuerySerializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(TypeFiltersBuilder b) {}

  /// The category of extensions to return.
  ///
  /// *   `REGISTERED`: Private extensions that have been registered for this account and region.
  ///
  /// *   `ACTIVATED`: Public extensions that have been activated for this account and region.
  ///
  /// *   `THIRD_PARTY`: Extensions available for use from publishers other than Amazon. This includes:
  ///
  ///     *   Private extensions registered in the account.
  ///
  ///     *   Public extensions from publishers other than Amazon, whether activated or not.
  ///
  /// *   `AWS_TYPES`: Extensions available for use from Amazon.
  _i2.Category? get category;

  /// The id of the publisher of the extension.
  ///
  /// Extensions published by Amazon aren't assigned a publisher ID. Use the `AWS_TYPES` category to specify a list of types published by Amazon.
  String? get publisherId;

  /// A prefix to use as a filter for results.
  String? get typeNamePrefix;
  @override
  List<Object?> get props => [
        category,
        publisherId,
        typeNamePrefix,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('TypeFilters');
    helper.add(
      'category',
      category,
    );
    helper.add(
      'publisherId',
      publisherId,
    );
    helper.add(
      'typeNamePrefix',
      typeNamePrefix,
    );
    return helper.toString();
  }
}

class TypeFiltersAwsQuerySerializer
    extends _i3.StructuredSmithySerializer<TypeFilters> {
  const TypeFiltersAwsQuerySerializer() : super('TypeFilters');

  @override
  Iterable<Type> get types => const [
        TypeFilters,
        _$TypeFilters,
      ];
  @override
  Iterable<_i3.ShapeId> get supportedProtocols => const [
        _i3.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsQuery',
        )
      ];
  @override
  TypeFilters deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypeFiltersBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current;
      iterator.moveNext();
      final value = iterator.current;
      switch (key as String) {
        case 'Category':
          if (value != null) {
            result.category = (serializers.deserialize(
              value,
              specifiedType: const FullType(_i2.Category),
            ) as _i2.Category);
          }
          break;
        case 'PublisherId':
          if (value != null) {
            result.publisherId = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
        case 'TypeNamePrefix':
          if (value != null) {
            result.typeNamePrefix = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final payload = (object as TypeFilters);
    final result = <Object?>[
      const _i3.XmlElementName(
        'TypeFiltersResponse',
        _i3.XmlNamespace('http://cloudformation.amazonaws.com/doc/2010-05-15/'),
      )
    ];
    if (payload.category != null) {
      result
        ..add(const _i3.XmlElementName('Category'))
        ..add(serializers.serialize(
          payload.category!,
          specifiedType: const FullType.nullable(_i2.Category),
        ));
    }
    if (payload.publisherId != null) {
      result
        ..add(const _i3.XmlElementName('PublisherId'))
        ..add(serializers.serialize(
          payload.publisherId!,
          specifiedType: const FullType(String),
        ));
    }
    if (payload.typeNamePrefix != null) {
      result
        ..add(const _i3.XmlElementName('TypeNamePrefix'))
        ..add(serializers.serialize(
          payload.typeNamePrefix!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}