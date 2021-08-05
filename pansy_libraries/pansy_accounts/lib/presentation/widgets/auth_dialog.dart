import 'package:pansy_accounts/presentation/presentation.dart';

class AuthDialog extends UDialogWidget {
  const AuthDialog({Key? key})
      : super(
          key: key,
          title: "Pansy Accounts",
          outline: true,
        );

  @override
  Widget buildBody({required Widget body}) {
    return UPansyTheme(child: body);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthDialogBloc, AuthDialogState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: UFrameLoader(
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
                      hintText: context.localizations.accounts.dialog.username,
                      controller: state.usernameController,
                      icon: Icon(Icons.ac_unit),
                    ),
                    SizedBox(height: 10),
                    UTextField(
                      hintText: context.localizations.accounts.dialog.password,
                      controller: state.passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
                UButton.outline(
                  onPressed: () => context.read<AuthDialogBloc>().auth(context),
                  child: Text(context.localizations.accounts.dialog.signin),
                ),
                UButton(
                  onPressed: () =>
                      context.read<AuthDialogBloc>().register(context),
                  child: Text(context.localizations.accounts.dialog.signup),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
