import 'package:bloc/bloc.dart';

class StockTubeTypeFillingStafCubit extends Cubit<int> {
  StockTubeTypeFillingStafCubit() : super(0);

  void setType(int newItem) {
    emit(newItem);
  }
}
