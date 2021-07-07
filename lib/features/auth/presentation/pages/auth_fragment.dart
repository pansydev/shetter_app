import 'package:shetter_app/features/auth/presentation/presentation.dart';

class AuthFragment extends StatelessWidget {
  const AuthFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UCard.outline(
      style: UCardStyle(
        margin: EdgeInsets.symmetric(
          horizontal: DesignConstants.paddingValue,
        ).copyWith(top: DesignConstants.paddingMiniValue),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return UFrameLoader(
            state: state.maybeMap(
              loading: (_) => UFrameLoaderState.loading(),
              orElse: () => UFrameLoaderState.initial(),
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
                      hintText: Strings.username.get(),
                      controller: state.usernameController,
                      icon: Icon(Icons.ac_unit),
                    ),
                    SizedBox(height: 10),
                    UTextField(
                      hintText: Strings.password.get(),
                      controller: state.passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
                UButton.outline(
                  onPressed: context.read<AuthBloc>().auth,
                  child: Text(
                    Strings.login.get(),
                  ),
                ),
                UButton(
                  onPressed: context.read<AuthBloc>().register,
                  child: Text(
                    Strings.signin.get(),
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
