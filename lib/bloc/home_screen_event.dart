part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

final class CategorySelected extends HomeScreenEvent {
  final String category;
  CategorySelected({required this.category});
}
