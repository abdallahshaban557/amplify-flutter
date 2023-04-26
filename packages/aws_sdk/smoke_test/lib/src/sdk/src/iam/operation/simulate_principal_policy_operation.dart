// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.iam.operation.simulate_principal_policy_operation; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i14;

import 'package:aws_common/aws_common.dart' as _i9;
import 'package:aws_signature_v4/aws_signature_v4.dart' as _i6;
import 'package:built_collection/built_collection.dart' as _i4;
import 'package:smithy/smithy.dart' as _i1;
import 'package:smithy_aws/smithy_aws.dart' as _i7;
import 'package:smoke_test/src/sdk/src/iam/common/endpoint_resolver.dart'
    as _i10;
import 'package:smoke_test/src/sdk/src/iam/common/serializers.dart' as _i8;
import 'package:smoke_test/src/sdk/src/iam/model/evaluation_result.dart' as _i5;
import 'package:smoke_test/src/sdk/src/iam/model/invalid_input_exception.dart'
    as _i11;
import 'package:smoke_test/src/sdk/src/iam/model/no_such_entity_exception.dart'
    as _i12;
import 'package:smoke_test/src/sdk/src/iam/model/policy_evaluation_exception.dart'
    as _i13;
import 'package:smoke_test/src/sdk/src/iam/model/simulate_policy_response.dart'
    as _i3;
import 'package:smoke_test/src/sdk/src/iam/model/simulate_principal_policy_request.dart'
    as _i2;

/// Simulate how a set of IAM policies attached to an IAM entity works with a list of API operations and Amazon Web Services resources to determine the policies' effective permissions. The entity can be an IAM user, group, or role. If you specify a user, then the simulation also includes all of the policies that are attached to groups that the user belongs to. You can simulate resources that don't exist in your account.
///
/// You can optionally include a list of one or more additional policies specified as strings to include in the simulation. If you want to simulate only policies specified as strings, use SimulateCustomPolicy instead.
///
/// You can also optionally include one resource-based policy to be evaluated with each of the resources included in the simulation.
///
/// The simulation does not perform the API operations; it only checks the authorization to determine if the simulated policies allow or deny the operations.
///
/// **Note:** This operation discloses information about the permissions granted to other users. If you do not want users to see other user's permissions, then consider allowing them to use SimulateCustomPolicy instead.
///
/// Context keys are variables maintained by Amazon Web Services and its services that provide details about the context of an API query request. You can use the `Condition` element of an IAM policy to evaluate context keys. To get the list of context keys that the policies require for correct simulation, use GetContextKeysForPrincipalPolicy.
///
/// If the output is long, you can use the `MaxItems` and `Marker` parameters to paginate the results.
///
/// For more information about using the policy simulator, see [Testing IAM policies with the IAM policy simulator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html) in the _IAM User Guide_.
class SimulatePrincipalPolicyOperation extends _i1.PaginatedHttpOperation<
    _i2.SimulatePrincipalPolicyRequest,
    _i2.SimulatePrincipalPolicyRequest,
    _i3.SimulatePolicyResponse,
    _i3.SimulatePolicyResponse,
    String,
    int,
    _i4.BuiltList<_i5.EvaluationResult>> {
  /// Simulate how a set of IAM policies attached to an IAM entity works with a list of API operations and Amazon Web Services resources to determine the policies' effective permissions. The entity can be an IAM user, group, or role. If you specify a user, then the simulation also includes all of the policies that are attached to groups that the user belongs to. You can simulate resources that don't exist in your account.
  ///
  /// You can optionally include a list of one or more additional policies specified as strings to include in the simulation. If you want to simulate only policies specified as strings, use SimulateCustomPolicy instead.
  ///
  /// You can also optionally include one resource-based policy to be evaluated with each of the resources included in the simulation.
  ///
  /// The simulation does not perform the API operations; it only checks the authorization to determine if the simulated policies allow or deny the operations.
  ///
  /// **Note:** This operation discloses information about the permissions granted to other users. If you do not want users to see other user's permissions, then consider allowing them to use SimulateCustomPolicy instead.
  ///
  /// Context keys are variables maintained by Amazon Web Services and its services that provide details about the context of an API query request. You can use the `Condition` element of an IAM policy to evaluate context keys. To get the list of context keys that the policies require for correct simulation, use GetContextKeysForPrincipalPolicy.
  ///
  /// If the output is long, you can use the `MaxItems` and `Marker` parameters to paginate the results.
  ///
  /// For more information about using the policy simulator, see [Testing IAM policies with the IAM policy simulator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html) in the _IAM User Guide_.
  SimulatePrincipalPolicyOperation({
    required String region,
    Uri? baseUri,
    _i6.AWSCredentialsProvider credentialsProvider =
        const _i6.AWSCredentialsProvider.environment(),
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
          _i2.SimulatePrincipalPolicyRequest,
          _i2.SimulatePrincipalPolicyRequest,
          _i3.SimulatePolicyResponse,
          _i3.SimulatePolicyResponse>> protocols = [
    _i7.AwsQueryProtocol(
      serializers: _i8.serializers,
      builderFactories: _i8.builderFactories,
      requestInterceptors: <_i1.HttpRequestInterceptor>[
            const _i1.WithHost(),
            const _i1.WithContentLength(),
            _i7.WithSigV4(
              region: _region,
              service: _i9.AWSService.iam,
              credentialsProvider: _credentialsProvider,
            ),
            const _i1.WithUserAgent('aws-sdk-dart/0.3.1'),
            const _i7.WithSdkInvocationId(),
            const _i7.WithSdkRequest(),
          ] +
          _requestInterceptors,
      responseInterceptors:
          <_i1.HttpResponseInterceptor>[] + _responseInterceptors,
      action: 'SimulatePrincipalPolicy',
      version: '2010-05-08',
      awsQueryErrors: const [
        _i7.AwsQueryError(
          shape: 'InvalidInputException',
          code: 'InvalidInput',
          httpResponseCode: 400,
        ),
        _i7.AwsQueryError(
          shape: 'NoSuchEntityException',
          code: 'NoSuchEntity',
          httpResponseCode: 404,
        ),
        _i7.AwsQueryError(
          shape: 'PolicyEvaluationException',
          code: 'PolicyEvaluation',
          httpResponseCode: 500,
        ),
      ],
    )
  ];

  late final _i7.AWSEndpoint _awsEndpoint = _i10.endpointResolver.resolve(
    _i10.sdkId,
    _region,
  );

  final String _region;

  final Uri? _baseUri;

  final _i6.AWSCredentialsProvider _credentialsProvider;

  final List<_i1.HttpRequestInterceptor> _requestInterceptors;

  final List<_i1.HttpResponseInterceptor> _responseInterceptors;

  @override
  _i1.HttpRequest buildRequest(_i2.SimulatePrincipalPolicyRequest input) =>
      _i1.HttpRequest((b) {
        b.method = 'POST';
        b.path = r'/';
      });
  @override
  int successCode([_i3.SimulatePolicyResponse? output]) => 200;
  @override
  _i3.SimulatePolicyResponse buildOutput(
    _i3.SimulatePolicyResponse payload,
    _i9.AWSBaseHttpResponse response,
  ) =>
      _i3.SimulatePolicyResponse.fromResponse(
        payload,
        response,
      );
  @override
  List<_i1.SmithyError> get errorTypes => const [
        _i1.SmithyError(
          _i1.ShapeId(
            namespace: 'com.amazonaws.iam',
            shape: 'InvalidInputException',
          ),
          _i1.ErrorKind.client,
          _i11.InvalidInputException,
          statusCode: 400,
          builder: _i11.InvalidInputException.fromResponse,
        ),
        _i1.SmithyError(
          _i1.ShapeId(
            namespace: 'com.amazonaws.iam',
            shape: 'NoSuchEntityException',
          ),
          _i1.ErrorKind.client,
          _i12.NoSuchEntityException,
          statusCode: 404,
          builder: _i12.NoSuchEntityException.fromResponse,
        ),
        _i1.SmithyError(
          _i1.ShapeId(
            namespace: 'com.amazonaws.iam',
            shape: 'PolicyEvaluationException',
          ),
          _i1.ErrorKind.server,
          _i13.PolicyEvaluationException,
          statusCode: 500,
          builder: _i13.PolicyEvaluationException.fromResponse,
        ),
      ];
  @override
  String get runtimeTypeName => 'SimulatePrincipalPolicy';
  @override
  _i7.AWSRetryer get retryer => _i7.AWSRetryer();
  @override
  Uri get baseUri => _baseUri ?? endpoint.uri;
  @override
  _i1.Endpoint get endpoint => _awsEndpoint.endpoint;
  @override
  _i1.SmithyOperation<_i3.SimulatePolicyResponse> run(
    _i2.SimulatePrincipalPolicyRequest input, {
    _i9.AWSHttpClient? client,
    _i1.ShapeId? useProtocol,
  }) {
    return _i14.runZoned(
      () => super.run(
        input,
        client: client,
        useProtocol: useProtocol,
      ),
      zoneValues: {
        ...?_awsEndpoint.credentialScope?.zoneValues,
        ...{_i9.AWSHeaders.sdkInvocationId: _i9.uuid(secure: true)}
      },
    );
  }

  @override
  String? getToken(_i3.SimulatePolicyResponse output) => output.marker;
  @override
  _i4.BuiltList<_i5.EvaluationResult> getItems(
          _i3.SimulatePolicyResponse output) =>
      output.evaluationResults ?? _i4.BuiltList();
  @override
  _i2.SimulatePrincipalPolicyRequest rebuildInput(
    _i2.SimulatePrincipalPolicyRequest input,
    String token,
    int? pageSize,
  ) =>
      input.rebuild((b) {
        b.marker = token;
        if (pageSize != null) {
          b.maxItems = pageSize;
        }
      });
}