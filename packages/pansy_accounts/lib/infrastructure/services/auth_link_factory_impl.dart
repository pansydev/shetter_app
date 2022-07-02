import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

import 'package:gql/ast.dart';

class AuthLinkFactoryImpl implements AuthLinkFactory {
  AuthLinkFactoryImpl(this._tokenManager, this._refreshManager);

  final TokenManager _tokenManager;
  final RefreshManager _refreshManager;

  @override
  Link createAuthLink() {
    final tokenLink = _buildTokenLink();
    final refreshLink = _buildRefreshLink();
    final errorLink = _buildErrorLink();

    return Link.from([tokenLink, refreshLink, errorLink]);
  }

  ErrorLink _buildErrorLink() {
    return ErrorLink(onGraphQLError: (request, forward, response) {
      if (response.errors == null) {
        return null;
      }

      final shouldRefresh = response.errors!.any(
        (element) => element.extensions?['code'] == 'AUTH_NOT_AUTHENTICATED',
      );

      if (!shouldRefresh) {
        return null;
      }

      return _refreshToken(request, forward, response);
    });
  }

  Link _buildRefreshLink() {
    return Link.function((request, [forward]) async* {
      if (!_tokenManager.authenticated) {
        if (forward != null) yield* forward(request);
        return;
      }

      final definition = request.operation.document.definitions[0];

      if (definition is! OperationDefinitionNode) {
        throw Exception('Failed to get operation definition');
      }

      final operationName = definition.name!.value;

      if (operationName != 'Refresh') {
        await _refreshManager.ensureRefreshed();
      }

      if (forward != null) {
        yield* forward(_updateRequest(request));
      }
    });
  }

  AuthLink _buildTokenLink() {
    return AuthLink(getToken: () async {
      if (!_tokenManager.authenticated) {
        return null;
      }

      return _getAccessToken();
    });
  }

  Stream<Response> _refreshToken(
    Request request,
    Stream<Response> Function(Request) forward,
    Response response,
  ) async* {
    await _refreshManager.ensureRefreshed(force: true);

    yield* forward(_updateRequest(request));
  }

  String _getAccessToken() {
    final accessToken = _tokenManager.tokens.accessToken.value;
    return 'Bearer $accessToken';
  }

  Request _updateRequest(Request request) {
    return request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: <String, String>{
          ...headers?.headers ?? <String, String>{},
          'Authorization': _getAccessToken(),
        },
      ),
    );
  }
}
