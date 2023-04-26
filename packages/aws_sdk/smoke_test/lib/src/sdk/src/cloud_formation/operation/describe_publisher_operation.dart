// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.cloud_formation.operation.describe_publisher_operation; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i10;

import 'package:aws_common/aws_common.dart' as _i7;
import 'package:aws_signature_v4/aws_signature_v4.dart' as _i4;
import 'package:smithy/smithy.dart' as _i1;
import 'package:smithy_aws/smithy_aws.dart' as _i5;
import 'package:smoke_test/src/sdk/src/cloud_formation/common/endpoint_resolver.dart'
    as _i8;
import 'package:smoke_test/src/sdk/src/cloud_formation/common/serializers.dart'
    as _i6;
import 'package:smoke_test/src/sdk/src/cloud_formation/model/cfn_registry_exception.dart'
    as _i9;
import 'package:smoke_test/src/sdk/src/cloud_formation/model/describe_publisher_input.dart'
    as _i2;
import 'package:smoke_test/src/sdk/src/cloud_formation/model/describe_publisher_output.dart'
    as _i3;

/// Returns information about a CloudFormation extension publisher.
///
/// If you don't supply a `PublisherId`, and you have registered as an extension publisher, `DescribePublisher` returns information about your own publisher account.
///
/// For more information about registering as a publisher, see:
///
/// *   [RegisterPublisher](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterPublisher.html)
///
/// *   [Publishing extensions to make them available for public use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html) in the _CloudFormation CLI User Guide_
class DescribePublisherOperation extends _i1.HttpOperation<
    _i2.DescribePublisherInput,
    _i2.DescribePublisherInput,
    _i3.DescribePublisherOutput,
    _i3.DescribePublisherOutput> {
  /// Returns information about a CloudFormation extension publisher.
  ///
  /// If you don't supply a `PublisherId`, and you have registered as an extension publisher, `DescribePublisher` returns information about your own publisher account.
  ///
  /// For more information about registering as a publisher, see:
  ///
  /// *   [RegisterPublisher](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterPublisher.html)
  ///
  /// *   [Publishing extensions to make them available for public use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html) in the _CloudFormation CLI User Guide_
  DescribePublisherOperation({
    required String region,
    Uri? baseUri,
    _i4.AWSCredentialsProvider credentialsProvider =
        const _i4.AWSCredentialsProvider.environment(),
    List<_i1.HttpRequestInterceptor> requestInterceptors = const [],
    List<_i1.HttpResponseInterceptor> responseInterceptors = const [],
  })  : _region = region,
        _baseUri = baseUri,
        _credentialsProvider = credentialsProvider,
        _requestInterceptors = requestInterceptors,
        _responseInterceptors = responseInterceptors;

  @override
  late final List<
      _i1.HttpProtocol<
          _i2.DescribePublisherInput,
          _i2.DescribePublisherInput,
          _i3.DescribePublisherOutput,
          _i3.DescribePublisherOutput>> protocols = [
    _i5.AwsQueryProtocol(
      serializers: _i6.serializers,
      builderFactories: _i6.builderFactories,
      requestInterceptors: <_i1.HttpRequestInterceptor>[
            const _i1.WithHost(),
            const _i1.WithContentLength(),
            _i5.WithSigV4(
              region: _region,
              service: _i7.AWSService.cloudFormation,
              credentialsProvider: _credentialsProvider,
            ),
            const _i1.WithUserAgent('aws-sdk-dart/0.3.1'),
            const _i5.WithSdkInvocationId(),
            const _i5.WithSdkRequest(),
          ] +
          _requestInterceptors,
      responseInterceptors:
          <_i1.HttpResponseInterceptor>[] + _responseInterceptors,
      action: 'DescribePublisher',
      version: '2010-05-15',
      awsQueryErrors: const [
        _i5.AwsQueryError(
          shape: 'CFNRegistryException',
          code: 'CFNRegistryException',
          httpResponseCode: 400,
        )
      ],
    )
  ];

  late final _i5.AWSEndpoint _awsEndpoint = _i8.endpointResolver.resolve(
    _i8.sdkId,
    _region,
  );

  final String _region;

  final Uri? _baseUri;

  final _i4.AWSCredentialsProvider _credentialsProvider;

  final List<_i1.HttpRequestInterceptor> _requestInterceptors;

  final List<_i1.HttpResponseInterceptor> _responseInterceptors;

  @override
  _i1.HttpRequest buildRequest(_i2.DescribePublisherInput input) =>
      _i1.HttpRequest((b) {
        b.method = 'POST';
        b.path = r'/';
      });
  @override
  int successCode([_i3.DescribePublisherOutput? output]) => 200;
  @override
  _i3.DescribePublisherOutput buildOutput(
    _i3.DescribePublisherOutput payload,
    _i7.AWSBaseHttpResponse response,
  ) =>
      _i3.DescribePublisherOutput.fromResponse(
        payload,
        response,
      );
  @override
  List<_i1.SmithyError> get errorTypes => const [
        _i1.SmithyError(
          _i1.ShapeId(
            namespace: 'com.amazonaws.cloudformation',
            shape: 'CFNRegistryException',
          ),
          _i1.ErrorKind.client,
          _i9.CfnRegistryException,
          statusCode: 400,
          builder: _i9.CfnRegistryException.fromResponse,
        )
      ];
  @override
  String get runtimeTypeName => 'DescribePublisher';
  @override
  _i5.AWSRetryer get retryer => _i5.AWSRetryer();
  @override
  Uri get baseUri => _baseUri ?? endpoint.uri;
  @override
  _i1.Endpoint get endpoint => _awsEndpoint.endpoint;
  @override
  _i1.SmithyOperation<_i3.DescribePublisherOutput> run(
    _i2.DescribePublisherInput input, {
    _i7.AWSHttpClient? client,
    _i1.ShapeId? useProtocol,
  }) {
    return _i10.runZoned(
      () => super.run(
        input,
        client: client,
        useProtocol: useProtocol,
      ),
      zoneValues: {
        ...?_awsEndpoint.credentialScope?.zoneValues,
        ...{_i7.AWSHeaders.sdkInvocationId: _i7.uuid(secure: true)}
      },
    );
  }
}