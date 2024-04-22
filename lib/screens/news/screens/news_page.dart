import 'package:application/screens/error/error_view_widget.dart';
import 'package:application/screens/news/models/news_models.dart';
import 'package:application/screens/news/news_bloc/news_bloc.dart';
import 'package:application/screens/news/screens/news.detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "news_row_item.dart";

part "news_list_items.dart";

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    newsBloc.add(LoadNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Новости',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          if (state is NewsInitial || state is NewsLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is NewsLoaded) {
            final newsResponse = state.newsResponse;
            return NewsListItems(
              newsResponse: newsResponse,
              newsBloc: newsBloc,
            );
          } else if (state is NewsError) {
            return ErrorViewWidget(
              message: state.exception.toString(),
            );
          } else {
            return const ErrorViewWidget();
          }
        }),
    );
  }
}