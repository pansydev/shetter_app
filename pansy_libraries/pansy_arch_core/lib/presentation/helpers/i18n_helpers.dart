import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

extension I18N on BuildContext {
  CoreLocalizations get localizations =>
      CoreLocalizations(read<ServiceProvider>(), this);
}
