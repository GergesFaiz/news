

import 'package:flutter/material.dart';
import 'package:news/home/news/news_details_bottom_sheet.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/news/news_view_model.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsViewModel viewModel = NewsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id ?? '');

  }
  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id) {
      viewModel.getNewsBySourceId(widget.source.id ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<NewsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return MainErrorWidget(
              onPressed: () {
                viewModel.getNewsBySourceId(widget.source.id ?? '');
              },
              massage: viewModel.errorMessage!,
            );
          } //todo: erorr
          else if (viewModel.newsList == null) {
            return MainLoadingWidget();
          } //todo: loading
          else {
            return viewModel.newsList!.isEmpty
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
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => NewsDetailsBottomSheet(
                              news: viewModel.newsList![index],
                            ),
                          );
                        },
                        child: NewsItem(news: viewModel.newsList![index]),
                      );
                    },
                    itemCount: viewModel.newsList!.length,
                  );
          } //todo: Success
        },
      ),
    );
  }
}
