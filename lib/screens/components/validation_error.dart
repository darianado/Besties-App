import 'package:flutter/material.dart';

/**
 * This class represents a widget that is used to display
 * a validation error message. It displays it as a text in red.
 */

class ValidationError extends StatelessWidget {
  final String? errorText;

  const ValidationError({
    Key? key,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (errorText == null || errorText == "") return Container();

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            errorText!,
            style:
                Theme.of(context).textTheme.bodySmall?.apply(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
