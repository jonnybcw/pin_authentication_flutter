import 'package:flutter/cupertino.dart';
import 'package:pin_authentication_flutter/modules/auth_by_pin_code/auth_by_pin_code_screen.dart';
import 'package:pin_authentication_flutter/modules/create_pin_code/create_pin_code_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Menu',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 18,
              ),
        ),
        backgroundColor: CupertinoColors.white,
        border: null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CupertinoListTile(
                title: const Text('Create PIN code'),
                trailing: const Icon(CupertinoIcons.chevron_forward),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const CreatePinCodeScreen(),
                    ),
                  );
                },
              ),
              CupertinoListTile(
                title: const Text('Authentication by PIN code'),
                trailing: const Icon(CupertinoIcons.chevron_forward),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const AuthByPinCodeScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
