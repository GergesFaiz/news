import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/news/Cubit/news_state.dart';
import 'package:news/home/news/Cubit/news_view_model.dart';
import 'package:news/home/news/news_details_bottom_sheet.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/screen_utils.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  NewsWidget({super.key, required this.source});

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
  Widget build(BuildContext context) {
    var height = context.height;
    return BlocProvider<NewsViewModel>(
      create: (context) => viewModel,
      child: BlocBuilder<NewsViewModel, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccessState) {
            return state.newsList.isEmpty
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
                              news: state.newsList[index],
                            ),
                          );
                        },
                        child: NewsItem(news: state.newsList[index]),
                      );
                    },
                    itemCount: state.newsList.length,
                  );
          } else if (state is NewsErrorState) {
            return MainErrorWidget(
              massage: state.errorMessage,
              onPressed: () {
                viewModel.getNewsBySourceId(widget.source.id ?? '');
              },
            );
          } else {
            return MainLoadingWidget();
          }
        },
      ),
    );
  }
}
