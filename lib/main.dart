import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final router = AppRouter();
  final provider = await ServiceProvider.create();

  final application = Application(router, provider);

  runApp(application);
}
