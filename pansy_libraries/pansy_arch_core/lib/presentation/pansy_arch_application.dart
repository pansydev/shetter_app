import 'package:flutter/material.dart';
import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';
import 'package:provider/single_child_widget.dart';

class PansyArchApplication extends StatelessWidget {
  PansyArchApplication({
    required this.child,
    required this.serviceProvider,
    this.providers,
  }) : super(key: Key("Pansy"));

  final Widget child;
  final ServiceProvider serviceProvider;
  final List<SingleChildWidget>? providers;

  @override
  Widget build(BuildContext context) {
    serviceProvider.resolve<BuildContextAccessor>().buildContext = context;

    return MultiProvider(
      providers: providers != null
          ? [Provider.value(value: serviceProvider), ...providers!]
          : [Provider.value(value: serviceProvider)],
      child: child,
    );
  }
}
