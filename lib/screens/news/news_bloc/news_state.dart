part of 'news_bloc.dart';

@immutable
abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsResponse newsResponse;
  const NewsLoaded({
    required this.newsResponse
  });
}

class NewsError extends NewsState {
  final Object? exception;
  const NewsError({
    required this.exception
  });
}

