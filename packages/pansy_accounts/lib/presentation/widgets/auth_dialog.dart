import 'package:pansy_accounts/presentation/presentation.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UPansyTheme(
      child: UDialog(
        title: 'Pansy Accounts',
        outline: true,
        child: BlocBuilder<AuthDialogBloc, AuthDialogState>(
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
                          hintText: localizations.accounts.dialog.username,
                          controller: state.usernameController,
                          icon: Icon(Icons.ac_unit),
                        ),
                        SizedBox(height: 10),
                        UTextField(
                          hintText: localizations.accounts.dialog.password,
                          controller: state.passwordController,
                          isPassword: true,
                        ),
                      ],
                    ),
                    UButton.outline(
                      onPressed: () =>
                          context.read<AuthDialogBloc>().auth(context),
                      child: Text(localizations.accounts.dialog.signin),
                    ),
                    UButton(
                      onPressed: () =>
                          context.read<AuthDialogBloc>().register(context),
                      child: Text(localizations.accounts.dialog.signup),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
