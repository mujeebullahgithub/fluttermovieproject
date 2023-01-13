import 'package:bloc/bloc.dart';

class TotalSearchedResults extends Cubit<int> {
  TotalSearchedResults() : super(0);
  void toChange(int num) => emit(num);
}
