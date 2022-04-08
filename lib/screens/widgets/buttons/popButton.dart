import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  const PopButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: const BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 16,
          )),
    );
  }
}
