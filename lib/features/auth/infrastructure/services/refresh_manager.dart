import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

// ignore: one_member_abstracts
abstract class RefreshManager {
  Future<Option<Failure>> ensureRefreshed({bool force});
}
