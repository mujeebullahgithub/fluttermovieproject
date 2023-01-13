import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');
  void toChange(String txt) => emit(txt);
  void getValue() => emit(state);
}
