import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

abstract class RefreshManager {
  Future<Option<Failure>> ensureRefreshed({bool force});
}
