part of 'news_page.dart';

class NewsItemView extends StatelessWidget {
  final Article? article;
  const NewsItemView({
    super.key,required this.article
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, 
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(article: article)));
        },
        child: Material(
          type: MaterialType.transparency, 
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Hero(
                              tag: article!.imageTag,
                              child: Image.network(
                                article?.urlToImage ?? "",
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/no-image-ru.jpg',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 4),
            
                        Hero(
                          tag: article!.timeTextTag,
                          child: Material(
                            child: Text(
                              article?.publishedAt ?? "Не указана дата",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 84, 84, 84),
                                fontSize: 12
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            
                    const SizedBox(width: 8),
            
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: article!.titleTextTag,
                            child: Material(
                              child: Text(
                                article?.title ?? "Не указано",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ),
                          Hero(
                            tag: article!.subTitleTextTag,
                            child: Material(
                              child: Text(
                                "Author: ${article?.author ?? "Не указано"}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 78, 78, 78)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                const Divider(
                  height: 4,
                  thickness: 1,
                  color: Color.fromARGB(255, 205, 204, 204),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}