import 'package:application/screens/news/models/news_models.dart';
import 'package:application/screens/news/news_bloc/news_repo.dart';
import 'package:application/services/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepo newsRepo = NewsRepo(Dio());

  NewsBloc() : super(NewsInitial()) {
    on<LoadNews> ((event, emit) async {
      try {
        emit(NewsLoading());  
        final NewsResponse newsResponse = await newsRepo.getNewsArticles(Utils.getNewsApiKey);
        emit(NewsLoaded(
          newsResponse: newsResponse
        ));
      } catch (e) {
        emit(NewsError(exception: e));
      }
    });
  }
}