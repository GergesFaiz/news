import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/api/Retrofit/model/news/news.dart';
import 'package:news/api/Retrofit/retrofit_service.dart';
import 'package:news/api/api_constants.dart';
import 'package:news/home/news/news_details_bottom_sheet.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/search/empty_search_widget.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _querySearch = '';
  bool _hasSearched = false;

  // FIX: كان PagingController<int, NewsResponse> — لازم يكون <int, News>
  late final PagingController<int, News> _pagingController =
  PagingController<int, News>(
    getNextPageKey: (state) =>
    state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) async {
      // FIX: searchNews بترجع NewsResponse — بنرجع articles (List<News>)
      final response = await RetrofitService(Dio()).searchNews(
        ApiConstants.apiKey,
        _querySearch,
        "publishedAt",
        20,
        pageKey,
      );
      return response.articles ?? [];
    },
  );

  void _onSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty || trimmed == _querySearch) return;
    _querySearch = trimmed;
    setState(() => _hasSearched = true);
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),

              // Search Bar
              TextField(
                controller: _controller,
                onSubmitted: _onSearch,
                textInputAction: TextInputAction.search,
                style: Theme.of(context).textTheme.labelMedium,
                decoration: InputDecoration(
                  hintText: 'Search for news...',
                  hintStyle: Theme.of(context).textTheme.labelSmall,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).splashColor,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).splashColor,
                    ),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _querySearch = '';
                        _hasSearched = false;
                      });
                      _pagingController.refresh();
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),

              SizedBox(height: height * 0.02),

              // Results
              Expanded(
                child: !_hasSearched
                    ? const EmptySearchWidget()
                    : PagingListener(
                  controller: _pagingController,
                  builder: (context, state, fetchNextPage) =>
                      PagedListView<int, News>(
                        state: state,
                        fetchNextPage: fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate<News>(
                          itemBuilder: (context, news, index) => Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: InkWell(
                              onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (_) =>
                                    NewsDetailsBottomSheet(news: news),
                              ),
                              child: NewsItem(news: news),
                            ),
                          ),
                          firstPageProgressIndicatorBuilder: (_) =>
                          const MainLoadingWidget(),
                          newPageProgressIndicatorBuilder: (_) =>
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          firstPageErrorIndicatorBuilder: (_) =>
                              MainErrorWidget(
                                massage: 'Something went wrong',
                                onPressed: _pagingController.refresh,
                              ),
                          newPageErrorIndicatorBuilder: (_) => Center(
                            child: TextButton(
                              onPressed: fetchNextPage,
                              child: const Text('Retry'),
                            ),
                          ),
                          noItemsFoundIndicatorBuilder: (_) => Center(
                            child: Text(
                              'No results for "$_querySearch"',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}