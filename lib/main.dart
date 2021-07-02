import 'package:shetter_app/application.dart';
import 'package:shetter_app/core/infrastructure/di/service_provider.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';
import 'package:shetter_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PostsPresentationLayer.ensureInitialized();

  final router = AppRouter();
  final application = Application(router);

  final provider = await ServiceProvider.create();

  final root = MultiBlocProvider(
    child: application,
    providers: [
      provider.createBlocProvider<PostListBloc>(),
    ],
  );

  runApp(root);
}
