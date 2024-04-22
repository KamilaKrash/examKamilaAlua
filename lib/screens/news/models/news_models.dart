import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'news_models.g.dart';

@JsonSerializable()
class NewsResponse {
  final String? status;
  final int? totalResults;
  final List<Article?>? articles;

  NewsResponse({
    required this.status, 
    required this.totalResults, 
    required this.articles
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);
}

@JsonSerializable()
class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  @JsonKey(includeFromJson: false,includeToJson: false) 
  late final int imageTag;
  @JsonKey(includeFromJson: false,includeToJson: false) 
  late final int titleTextTag;
  @JsonKey(includeFromJson: false,includeToJson: false) 
  late final int subTitleTextTag;
  @JsonKey(includeFromJson: false,includeToJson: false) 
  late final int timeTextTag;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  }) {
    imageTag = UniqueKey().hashCode;
    titleTextTag = UniqueKey().hashCode;
    subTitleTextTag = UniqueKey().hashCode;
    timeTextTag = UniqueKey().hashCode;
  }

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@JsonSerializable()
class Source {
  final String? id;
  final String? name;

  Source({
    required this.id, 
    required this.name
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}