import 'package:flutter/material.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  const ErrorViewWidget({super.key, this.message = "Неопознанная ошибка"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.build,
            size: 120,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Произошла ошибка',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
    );
  }
}
