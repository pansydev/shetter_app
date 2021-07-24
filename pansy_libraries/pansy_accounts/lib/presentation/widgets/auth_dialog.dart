import 'package:pansy_accounts/presentation/presentation.dart';

class AuthDialog extends UDialogWidget {
  const AuthDialog({Key? key}) : super(key: key, title: "Pansy Accounts");

  @override
  Widget build(BuildContext context) {
    return UCard.outline(
      style: UCardStyle(
        margin: EdgeInsets.symmetric(
          horizontal: DesignConstants.paddingValue,
        ).copyWith(top: DesignConstants.paddingMiniValue),
      ),
      child: BlocBuilder<AuthDialogBloc, AuthDialogState>(
        builder: (context, state) {
          return UFrameLoader(
            state: state.maybeMap(
              loading: (_) => UFrameLoaderState.loading,
              orElse: () => UFrameLoaderState.initial,
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UTextField(
                      hintText: "Strings.username.get()",
                      controller: state.usernameController,
                      icon: Icon(Icons.ac_unit),
                    ),
                    SizedBox(height: 10),
                    UTextField(
                      hintText: "Strings.password.get()",
                      controller: state.passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
                UButton.outline(
                  onPressed: () => context.read<AuthDialogBloc>().auth(context),
                  child: Text(
                    "Strings.login.get()",
                  ),
                ),
                UButton(
                  onPressed: () =>
                      context.read<AuthDialogBloc>().register(context),
                  child: Text(
                    "Strings.signin.get()",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
