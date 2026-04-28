
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/sources/source_widget.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/Category.dart';
import 'package:news/model/source_response.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;
   CategoryDetails({super.key,required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        //todo:loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        else if (snapshot.hasError) {
          //todo: Error
          return MainErrorWidget(
            onPressed: () {
              ApiManager.getSources(widget.category.id);
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
              ApiManager.getSources(widget.category.id);
              setState(() {});
            },
            massage: snapshot.data!.message!,
          );
        }

        //todo:response= Success
        List<Source> sourcesList = snapshot.data?.sources ?? [];
        return sourcesList.isEmpty?
        Center(child: Text('No Sources Found',style: Theme.of(context).textTheme.labelLarge,))
            :
          SourceWidget(sourcesList: sourcesList);
      },
    );
  }
}
