import 'package:bloc/bloc.dart';

class StockTubeTypeCubit extends Cubit<int> {
  StockTubeTypeCubit() : super(0);

  void setType(int newItem) {
    emit(newItem);
  }
}
