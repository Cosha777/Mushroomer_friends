import 'package:flutter/material.dart';
import 'package:mushroom_friends/generated/l10n.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.fun,
  });

  final String title;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: fun,
            child: Text(S.of(context).alertDialogAccept,
                style: const TextStyle(color: Colors.redAccent))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).alertDialogCancel,
                style: const TextStyle(color: Colors.blue))),
      ],
    );
  }
}
