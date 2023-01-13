import 'package:bloc/bloc.dart';

class SearchDoneCubit extends Cubit<bool> {
  SearchDoneCubit() : super(false);
  void toChange() => emit(!state);
}
