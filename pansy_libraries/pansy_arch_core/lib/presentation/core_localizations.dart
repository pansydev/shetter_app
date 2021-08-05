import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

class CoreLocalizations {
  CoreLocalizations(this._provider, this._context);

  ServiceProvider _provider;
  BuildContext _context;

  resolve<T extends Object>() {
    return _provider.resolve<T>(
      param1: Localizations.localeOf(_context).languageCode,
    );
  }
}
