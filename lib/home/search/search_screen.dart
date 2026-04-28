import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/news/news_details_bottom_sheet.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/search/empty_search_widget.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/utils/screen_utils.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller1 = TextEditingController();
  Future<NewResponse>? searchFuture;
  String querySearch = '';

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              // Search bar
              TextField(
                controller: controller1,
                onSubmitted: onSearch,
                textInputAction: TextInputAction.search,
                style: Theme.of(context).textTheme.labelMedium,
                decoration: InputDecoration(
                  hintText: 'Search for news...',
                  hintStyle: Theme.of(context).textTheme.labelSmall,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).splashColor,
                  ),
                  suffixIcon: controller1.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).splashColor,
                          ),
                          onPressed: () {
                            controller1.clear();
                            setState(() {
                              searchFuture = null;
                              querySearch = '';
                            });
                          },
                        )
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).splashColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).splashColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (v) => setState(() {}),
              ),
              SizedBox(height: height * 0.02),

              // Results
              Expanded(
                child: searchFuture == null
                    ? EmptySearchWidget()
                    : FutureBuilder<NewResponse>(
                        future: searchFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return MainLoadingWidget();
                          }
                          if (snapshot.hasError) {
                            return MainErrorWidget(
                              massage: 'Something went wrong',
                              onPressed: () => onSearch(controller1.text),
                            );
                          }
                          if (snapshot.data?.status != 'ok') {
                            return MainErrorWidget(
                              massage:
                                  snapshot.data?.message ?? 'Unknown error',
                              onPressed: () => onSearch(controller1.text),
                            );
                          }

                          final newsList = snapshot.data?.articles ?? [];
                          if (newsList.isEmpty) {
                            return Center(
                              child: Text(
                                'No results for "$querySearch"',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: newsList.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: height * 0.02),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          NewsDetailsBottomSheet(news: newsList[index]),
                                    );
                                  },
                                  child: NewsItem(news: newsList[index]));
                            }
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty || trimmed == querySearch) return;
    querySearch = trimmed;
    setState(() {
      searchFuture = ApiManager.searchNews(trimmed);
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }
}
