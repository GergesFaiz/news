import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;
  final VoidCallback? onTap;

   NewsItem({super.key, required this.news, this.onTap});

  @override
  Widget build(BuildContext context) {
    DateTime? postDate;
    try {
      postDate = DateTime.parse(news.publishedAt ?? '').toLocal();
    } catch (_) {
      postDate = DateTime.now();
    }
    String timeResult = timeago.format(postDate);

    var width = context.width;
    var height = context.height;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).splashColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>  MainLoadingWidget(),
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    color: Theme.of(context).splashColor.withOpacity(0.1),
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Theme.of(context).splashColor.withOpacity(0.4),
                      size: 40,
                    ),
                  ),
                ),
              ),
            SizedBox(height: height * 0.015),
            Text(
              news.title ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'By: ${news.author ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                 SizedBox(width: 8),
                Text(
                  timeResult,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
