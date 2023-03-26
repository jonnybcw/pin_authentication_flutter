import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinKeyboard extends StatelessWidget {
  PinKeyboard({
    required this.keyPressed,
    Key? key,
  }) : super(key: key);

  final Function(String) keyPressed;

  final List<String> _keys = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    'backspace'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          mainAxisExtent: 90,
        ),
        itemBuilder: (context, index) {
          String key = _keys[index];
          if (key.isEmpty) {
            return Container();
          } else if (key == 'backspace') {
            return CupertinoButton(
              child: const Icon(
                Icons.backspace_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                keyPressed(key);
              },
            );
          }
          return GestureDetector(
            onTap: () {
              keyPressed(key);
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemGrey6,
              ),
              child: Center(
                child: Text(
                  key,
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navTitleTextStyle
                      .copyWith(
                        color: CupertinoColors.systemGrey,
                        fontSize: 28,
                      ),
                ),
              ),
            ),
          );
        },
        itemCount: _keys.length,
      ),
    );
  }
}
