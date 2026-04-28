import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/news/news_item.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/utils/screen_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<NewResponse>? _searchFuture;
  String _query = '';

  void _onSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty || trimmed == _query) return;
    _query = trimmed;
    setState(() {
      _searchFuture = ApiManager.searchNews(trimmed);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            // Search bar
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
                        icon: Icon(Icons.clear,
                            color: Theme.of(context).splashColor),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _searchFuture = null;
                            _query = '';
                          });
                        },
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).splashColor.withOpacity(0.4),
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
              onChanged: (v) => setState(() {}),
            ),
            SizedBox(height: height * 0.02),

            // Results
            Expanded(
              child: _searchFuture == null
                  ? _EmptySearch()
                  : FutureBuilder<NewResponse>(
                      future: _searchFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const MainLoadingWidget();
                        }
                        if (snapshot.hasError) {
                          return MainErrorWidget(
                            massage: 'Something went wrong',
                            onPressed: () => _onSearch(_controller.text),
                          );
                        }
                        if (snapshot.data?.status != 'ok') {
                          return MainErrorWidget(
                            massage:
                                snapshot.data?.message ?? 'Unknown error',
                            onPressed: () => _onSearch(_controller.text),
                          );
                        }
                        final articles = snapshot.data?.articles ?? [];
                        if (articles.isEmpty) {
                          return Center(
                            child: Text(
                              'No results for "$_query"',
                              style:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: articles.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: height * 0.02),
                          itemBuilder: (context, index) =>
                              NewsItem(news: articles[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).splashColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Search for anything...',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
