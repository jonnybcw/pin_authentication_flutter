import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_authentication_flutter/modules/create_pin_code/bloc/create_pin_code_cubit.dart';
import 'package:pin_authentication_flutter/util/components/pin_code_indicator.dart';
import 'package:pin_authentication_flutter/util/components/pin_keyboard.dart';

class CreatePinCodeScreen extends StatefulWidget {
  const CreatePinCodeScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinCodeScreen> createState() => _CreatePinCodeScreenState();
}

class _CreatePinCodeScreenState extends State<CreatePinCodeScreen> {
  late CreatePinCodeCubit cubit;

  @override
  void initState() {
    cubit = CreatePinCodeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Setup PIN',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 18,
              ),
        ),
        trailing: Text(
          'Use 6-digits PIN',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 16,
                color: CupertinoColors.systemGrey2,
              ),
        ),
        backgroundColor: CupertinoColors.white,
        border: null,
      ),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => cubit,
          child: BlocConsumer<CreatePinCodeCubit, CreatePinCodeState>(
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
                            if (message.contains('successfully')) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                        )
                      ],
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is CreatePinCodeIdle) {
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.step == 0
                                ? 'Create PIN'
                                : 'Re-enter your PIN',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 24,
                                  color: CupertinoColors.systemGrey,
                                ),
                          ),
                          const SizedBox(height: 36),
                          PinCodeIndicator(text: state.currentFieldState.text),
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
