import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_authentication_flutter/modules/auth_by_pin_code/bloc/auth_by_pin_code_cubit.dart';
import 'package:pin_authentication_flutter/util/components/pin_code_indicator.dart';
import 'package:pin_authentication_flutter/util/components/pin_keyboard.dart';

class AuthByPinCodeScreen extends StatefulWidget {
  const AuthByPinCodeScreen({Key? key}) : super(key: key);

  @override
  State<AuthByPinCodeScreen> createState() => _AuthByPinCodeScreenState();
}

class _AuthByPinCodeScreenState extends State<AuthByPinCodeScreen> {
  late AuthByPinCodeCubit cubit;

  @override
  void initState() {
    cubit = AuthByPinCodeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: null,
      ),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => cubit,
          child: BlocConsumer<AuthByPinCodeCubit, AuthByPinCodeState>(
            listener: (context, state) {
              if (state is CreatePinCodeIdle) {
                String? message = state.message;
                if (message != null) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      content: Text(
                        message,
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      actions: [
                        CupertinoButton(
                          child: const Text(
                            'OK',
                            style: TextStyle(color: CupertinoColors.systemBlue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is PinNotCreated) {
                return Center(
                  child: Text(
                    "You haven't created a PIN yet",
                    style:
                        CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 24,
                              color: CupertinoColors.systemGrey,
                            ),
                  ),
                );
              } else if (state is CreatePinCodeIdle) {
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter your PIN',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 24,
                                  color: CupertinoColors.systemGrey,
                                ),
                          ),
                          const SizedBox(height: 36),
                          PinCodeIndicator(text: state.pinFieldState.text),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PinKeyboard(keyPressed: (String key) {
                        cubit.keyPressed(key: key);
                      }),
                    ),
                  ],
                );
              }
              return const Center(child: CupertinoActivityIndicator());
            },
          ),
        ),
      ),
    );
  }
}
