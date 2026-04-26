import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;
  late var postDate = DateTime.now().subtract(Duration(minutes:DateTime.parse(news.publishedAt ?? '').minute));


   NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {

    String result = timeago.format(postDate, locale: 'ar');
    var width = context.width;
    var height = context.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02 ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02 ,vertical: height*0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).splashColor, width: 2),
      ),

      child: Column(
        spacing: height * 0.02,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => MainLoadingWidget(),
              errorWidget: (context, url, error) => Icon(Icons.error,color: Theme.of(context).canvasColor,),
            ),
          ),
          Text(
              news.title ?? '', style: Theme.of(context).textTheme.labelLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'By:${news.author ?? ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),

              Text(result,
                // news.publishedAt ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
