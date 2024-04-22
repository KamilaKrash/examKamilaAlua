import 'package:application/screens/news/models/news_models.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final Article? article;
  const NewsDetail({
    super.key,
    required this.article
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> with SingleTickerProviderStateMixin{

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  late final Animation<double> opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(controller);

  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Hero(
                tag: widget.article!.imageTag,
                child: Image.network(
                  widget.article?.urlToImage ?? "",
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/no-image-ru.jpg');
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Hero(
              tag: widget.article!.timeTextTag,
              child: Material(
                child: Text(
                  widget.article?.publishedAt ?? "Не указана дата",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontSize: 12
                  ),
                ),
              ),
            ),
            
            Hero(
              tag: widget.article!.titleTextTag,
              child: Material(
                child: Text(
                  widget.article?.title ?? "Не указано",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),
            
            Hero(
              tag: widget.article!.subTitleTextTag,
              child: Material(
                child: Text(
                  "Author: ${widget.article?.author ?? "Не указано"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color.fromARGB(255, 78, 78, 78)
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            FadeTransition(
              opacity: opacityAnimation,
              child: Text(
                widget.article?.content.toString() ?? "Не указан контент",
                style: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}