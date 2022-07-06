import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/news_app/cubit/states.dart';
import 'package:flutter_app/modules/models/news_models.dart';
import 'package:flutter_app/modules/settings/settings_screen.dart';
import 'package:flutter_app/modules/sports/sports_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/bussiness/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> BottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settingd"),
  ];
  var currentIndex = 0;
  List<Widget> Screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingScreen(),
  ];
  void ChangeNavBottomBar(int index) {
    currentIndex = index;
    emit(NewsBottomNav());
  }

  getNews() {
    //Loading
    // getDataFunction
    // Success // Error
  }
  NewsModel? businessNewsModel;
  NewsModel? scienceNewsModel;
  NewsModel? sportsNewsModel;

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "aaf0b4a862e2482bb508a20c4eb07e67",
    }).then((value) {
      businessNewsModel = NewsModel.fromJson(value.data);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "category": "sports",
      "apiKey": "aaf0b4a862e2482bb508a20c4eb07e67",
    }).then((value) {
      sportsNewsModel = NewsModel.fromJson(value.data);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "category": "science",
      "apiKey": "aaf0b4a862e2482bb508a20c4eb07e67",
    }).then((value) {
      scienceNewsModel = NewsModel.fromJson(value.data);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }
}
