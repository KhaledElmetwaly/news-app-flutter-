import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:flutter_app/layout/news_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return ConditionalBuilder(
          condition:
              state is! NewsLoadingState && cubit.sportsNewsModel != null,
          builder: (context) => ListView.builder(itemBuilder: (context, index) {
            if (cubit.sportsNewsModel!.articles![index].urlToImage != null) {
              return buildArticleItems(cubit.sportsNewsModel!.articles![index]);
            } else {
              return SizedBox.shrink();
            }
          }),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
