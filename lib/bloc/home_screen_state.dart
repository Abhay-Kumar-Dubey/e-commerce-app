part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class SelectedCategory extends HomeScreenState {
  final String Category;
  SelectedCategory({required this.Category});
}
