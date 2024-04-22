part of 'news_page.dart';

class NewsListItems extends StatefulWidget {
  final NewsResponse newsResponse;
  final NewsBloc newsBloc;
  const NewsListItems({
    super.key,
    required this.newsResponse,
    required this.newsBloc,
  });
  @override
  State<NewsListItems> createState() => _NewsListItemsState();
}

class _NewsListItemsState extends State<NewsListItems> with SingleTickerProviderStateMixin{
  late final animationController = AnimationController(vsync: this);
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final List<Article?> _items = [];

  int counter = 0;

  @override
  void initState() {
    super.initState();
    animationController.duration = const Duration(milliseconds: 300);
    counter += 5;
    _items.addAll(
      widget.newsResponse.articles!.sublist(
        0,
        counter <= (widget.newsResponse.articles?.length ?? 0)
          ? counter
          : (widget.newsResponse.articles?.length ?? 0)
      ) 
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => Future.sync(() => widget.newsBloc.add(LoadNews())),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Text(
            "Всего артиклей: ${widget.newsResponse.totalResults.toString()}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 82, 82, 82)
            ),
          ),
          
          const Divider(),

          AnimatedList(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: listKey,
            initialItemCount: _items.length,
            itemBuilder:(context, index, animation) {
              return slideIt(context, index, animation);
            },
          ),
          if (counter < (widget.newsResponse.articles?.length ?? 0))
            TextButton(
              onPressed: () {
                int itemsToAdd = 1;

                if (counter + itemsToAdd >= (widget.newsResponse.articles?.length ?? 0)) {
                  itemsToAdd = (widget.newsResponse.articles?.length ?? 0) - counter;
                }

                setState(() {
                  listKey.currentState?.insertAllItems(
                    _items.length,
                    itemsToAdd,
                    duration: const Duration(milliseconds: 500),
                  );
                  _items.addAll(widget.newsResponse.articles!.sublist(
                    counter,
                    counter + itemsToAdd,
                  ));
                  counter += itemsToAdd;
                });

              }, 
              child: const Text("Показать еще одну новость")
            ),

          if (counter == (widget.newsResponse.articles?.length ?? 0)) 
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Text(
                "Новости первой страницы закончились.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ), 
              ),
            )
        ],
      ),
    );
  }

  Widget slideIt(BuildContext context, int index, animation) {
    Article? item = _items[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: NewsItemView(
        article: item,
      )
    );
  }
}