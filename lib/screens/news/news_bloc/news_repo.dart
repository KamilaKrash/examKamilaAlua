import 'package:application/screens/news/models/news_models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'news_repo.g.dart';

@RestApi(baseUrl: "https://newsapi.org")
abstract class NewsRepo {
  factory NewsRepo(Dio dio, {String baseUrl}) = _NewsRepo;

  @GET("/v2/top-headlines")
  Future<NewsResponse> getNewsArticles(
    @Query("apiKey") String apiKey,
    {@Query("country") String county = "us"}
  );
}