import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_utils.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return FutureBuilder<NewResponse>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        //todo:loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        } else if (snapshot.hasError) {
          //todo: Error
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
            massage: 'Something went wrong',
          );
        }
        //todo: server => response=> success , error
        else if (snapshot.data?.status != 'ok') {
          //todo:response= Error
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
            massage: snapshot.data!.message!,
          );
        }

        //todo:response= Success
        var newsList = snapshot.data?.articles ?? [];
        return newsList.isEmpty
            ? Center(
                child: Text(
                  'No News Found',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                itemBuilder: (context, index) {
                  return NewsItem(news: newsList[index]);
                },
                itemCount: newsList.length,
              );
      },
    );
  }
}
