import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';
import 'package:shetter_app/modules/posts/presentation/presentation.dart';

extension ShetterInitializer on ServiceCollection {
  void configureShetter() {
    addSingleton<HiveBoxFactory>();
    addSingletonFactory(HiveBoxFactory.create);

    addSingleton<GraphQLClientFactory>();
    addSingletonFactory(GraphQLClientFactory.create);

    addSingleton<PostRepositoryImpl>();
    addSingleton<PostFormBloc>();
    addSingleton<PostHistoryBloc>();
    addSingleton<PostListBloc>();

    configureI18N({
      'en': LocaleDescriptor(const Shetter(), shetterMap),
      'ru': LocaleDescriptor(const ShetterRu(), shetterRuMap),
    });
  }
}
