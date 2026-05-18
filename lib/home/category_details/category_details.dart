import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/source_state.dart';
import 'package:news/home/category_details/source_view_model.dart';
import 'package:news/home/category_details/sources/source_widget.dart';
import 'package:news/home/widget/main_error_widget.dart';
import 'package:news/home/widget/main_loading_widget.dart';
import 'package:news/model/Category.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class CategoryDetails extends StatefulWidget {
  final Category category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  SourceViewModel viewModel = SourceViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<SourceViewModel, SourceState>(
        builder: (context, state) {
          if (state is SourceSuccessState) {
            return state.sourcesList.isEmpty
                ? Center(
                    child: Text(
                      'No Sources Found',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
                : SourceWidget(sourcesList: state.sourcesList);
          }
          else if (state is SourceErrorState) {
            return MainErrorWidget(
              massage: state.errorMessage,
              onPressed: () {
                viewModel.getSources(widget.category.id);
              },
            );
          }
          else {
            return MainLoadingWidget();
          }
        },
      ),
    );
  }
}
