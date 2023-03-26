import 'package:flutter/cupertino.dart';

class PinCodeIndicator extends StatelessWidget {
  const PinCodeIndicator({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: text.length > index
                    ? CupertinoColors.systemPurple
                    : CupertinoColors.systemGrey,
              ),
              color: text.length > index ? CupertinoColors.systemPurple : null,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 32);
        },
        itemCount: 4,
      ),
    );
  }
}
