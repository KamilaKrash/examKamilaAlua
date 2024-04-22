part of 'login_screen.dart';

class Button extends StatelessWidget {
  final Function action;
  final Color    backgroundColor;
  final String   text;
  const Button({
    super.key,
    required this.action,
    required this.backgroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    late final double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: width * 0.1,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundColor)
        ),
        onPressed: () {
          action.call();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}