part of "profile_page.dart";

class ProfileRowItem extends StatelessWidget {
  final Color color;
  final bool? isHeader;
  final bool? isFooter;
  final bool? isBothHeaderFooter;
  final IconData iconData;
  final String text;
  const ProfileRowItem(
      {super.key,
      this.isHeader,
      this.isFooter,
      this.isBothHeaderFooter,
      required this.color,
      required this.iconData,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: (isFooter != null && isFooter!)
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : (isHeader != null && isHeader!)
                ? const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )
                : (isBothHeaderFooter != null && isBothHeaderFooter!)
                    ? const BorderRadius.all(
                        Radius.circular(12),
                      )
                    : null
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Text(
                text, 
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                )
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 15,
          ),
        ],
      ),
    );
  }
}