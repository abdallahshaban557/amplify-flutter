// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.cloud_formation.model.operation_not_found_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'operation_not_found_exception.g.dart';

/// The specified ID refers to an operation that doesn't exist.
abstract class OperationNotFoundException
    with _i1.AWSEquatable<OperationNotFoundException>
    implements
        Built<OperationNotFoundException, OperationNotFoundExceptionBuilder>,
        _i2.SmithyHttpException {
  /// The specified ID refers to an operation that doesn't exist.
  factory OperationNotFoundException({String? message}) {
    return _$OperationNotFoundException._(message: message);
  }

  /// The specified ID refers to an operation that doesn't exist.
  factory OperationNotFoundException.build(
          [void Function(OperationNotFoundExceptionBuilder) updates]) =
      _$OperationNotFoundException;

  const OperationNotFoundException._();

  /// Constructs a [OperationNotFoundException] from a [payload] and [response].
  factory OperationNotFoundException.fromResponse(
    OperationNotFoundException payload,
    _i1.AWSBaseHttpResponse response,
  ) =>
      payload.rebuild((b) {
        b.headers = response.headers;
      });

  static const List<_i2.SmithySerializer> serializers = [
    OperationNotFoundExceptionAwsQuerySerializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(OperationNotFoundExceptionBuilder b) {}
  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
        namespace: 'com.amazonaws.cloudformation',
        shape: 'OperationNotFoundException',
      );
  @override
  _i2.RetryConfig? get retryConfig => null;
  @override
  @BuiltValueField(compare: false)
  int get statusCode => 404;
  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('OperationNotFoundException');
    helper.add(
      'message',
      message,
    );
    return helper.toString();
  }
}

class OperationNotFoundExceptionAwsQuerySerializer
    extends _i2.StructuredSmithySerializer<OperationNotFoundException> {
  const OperationNotFoundExceptionAwsQuerySerializer()
      : super('OperationNotFoundException');

  @override
  Iterable<Type> get types => const [
        OperationNotFoundException,
        _$OperationNotFoundException,
      ];
  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
        _i2.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsQuery',
        )
      ];
  @override
  OperationNotFoundException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OperationNotFoundExceptionBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current;
      iterator.moveNext();
      final value = iterator.current;
      switch (key as String) {
        case 'Message':
          if (value != null) {
            result.message = (serializers.deserialize(
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
    final payload = (object as OperationNotFoundException);
    final result = <Object?>[
      const _i2.XmlElementName(
        'OperationNotFoundExceptionResponse',
        _i2.XmlNamespace('http://cloudformation.amazonaws.com/doc/2010-05-15/'),
      )
    ];
    if (payload.message != null) {
      result
        ..add(const _i2.XmlElementName('Message'))
        ..add(serializers.serialize(
          payload.message!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}