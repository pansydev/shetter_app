import 'package:pansy_accounts/presentation/presentation.dart';

class AuthButton extends UDialogWidget {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return UAnimatedVisibility(
          visible: state is AuthStateUnauthenticated,
          child: UPansyTheme(
            child: UButton.outline(
              icon: Icon(Icons.login),
              style: UButtonStyle(
                margin: EdgeInsets.symmetric(
                  horizontal: DesignConstants.paddingValue,
                ).copyWith(top: DesignConstants.paddingMiniValue),
                padding: DesignConstants.paddingAlt,
              ),
              child: Text('Авторизоваться через Pansy'),
              onPressed: () => AuthDialog().show(context),
            ),
          ),
        );
      },
    ).sliverBox;
  }
}
