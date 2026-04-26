import 'package:flutter/material.dart';
import 'package:news/home/category_details/category_details.dart';
import 'package:news/home/category_details/sources/source_name.dart';
import 'package:news/home/news/news_widget.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/screen_utils.dart';

class SourceWidget extends StatefulWidget {
  final List<Source> sourcesList;

   SourceWidget({super.key,required this.sourcesList});

  @override
  State<SourceWidget> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourceWidget> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(spacing: height*0.02,
          children: [
            TabBar(
              onTap: (index) {
                selectedIndex=index;
                setState(() {

                });
              },
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Theme.of(context).splashColor,
                dividerColor: AppColors.transparentColor,
                tabs: widget.sourcesList.map(
                  (source) {
                    return SourceName(
                        source: source,
                        isSelected: selectedIndex==widget.sourcesList.indexOf(source));
                  },
                ).toList()
            ),
            Expanded(child: NewsWidget(source:widget.sourcesList[selectedIndex],))

          ],
        ));
  }
}
