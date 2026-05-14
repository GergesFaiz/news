import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/source_view_model.dart';
import 'package:news/home/category_details/sources/source_widget.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/Category.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;


  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  SourceViewModel viewModel = SourceViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSource(widget.category.id);

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SourceViewModel>(
        builder: (context, viewModel, child) {

            if (viewModel.errorMassege != null) {
              //todo: Error
              return MainErrorWidget(
                onPressed: () {
                  viewModel.getSource(widget.category.id);
                },
                massage: 'Something went wrong',
              );
            } //todo: erorr
            else if (viewModel.sourcesList == null) {
              return MainLoadingWidget();
            } //todo: loading
            else  {
              return viewModel.sourcesList!.isEmpty
                  ? Center(
                      child: Text(
                        'No Sources Found',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )
                  : SourceWidget(sourcesList: viewModel.sourcesList!);
            } //todo: Success

        },
      ),
    );
  }
}
