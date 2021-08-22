import 'package:pansy_accounts/domain/domain.dart';

abstract class RefreshManager {
  Future<Option<Failure>> ensureRefreshed({bool force});
}
