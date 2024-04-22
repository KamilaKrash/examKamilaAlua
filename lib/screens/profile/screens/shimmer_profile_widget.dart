part of "profile_page.dart";

class ShimmerProfileWidget extends StatelessWidget {
  const ShimmerProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 251, 251, 251),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: const EdgeInsets.only(left: 5, right: 5),
      height: 90,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(width: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(25) ,
          child: const ShimmerWidget.rectangular(
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangular(
              height: 20,
              width: 100,
            ),
            SizedBox(
              height: 6,
            ),
            ShimmerWidget.rectangular(
              height: 20,
              width: 160,
            ),
          ]
        ),
      ]),
    );
  }
}