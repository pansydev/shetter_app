import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

@Singleton(as: AuthLinkFactory, dependsOn: [TokenManager])
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

      final isRefreshError = response.errors!.any(
        (element) => element.extensions!["code"] == "AUTH_NOT_AUTHENTICATED",
      );

      if (!isRefreshError) {
        return null;
      }

      return _refreshToken(request, forward, response);
    });
  }

  Link _buildRefreshLink() {
    return Link.function((request, [forward]) async* {
      if (request.operation.operationName != "Refresh") {
        await _refreshManager.ensureRefreshed();
      }

      if (forward != null) {
        yield* forward(request);
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

    final updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: <String, String>{
          ...headers?.headers ?? <String, String>{},
          "Authentication": _getAccessToken(),
        },
      ),
    );

    yield* forward(updatedRequest);
  }

  String _getAccessToken() {
    final accessToken = _tokenManager.tokens.accessToken.value;
    return "Bearer ${accessToken}";
  }
}
