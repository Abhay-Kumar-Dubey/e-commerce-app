import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategorySelected>(_categorySelected);
  }

  void _categorySelected(
      CategorySelected event, Emitter<HomeScreenState> emit) {
    emit(SelectedCategory(Category: event.category));
  }
}
