import 'package:bloc/bloc.dart';

class TravelDocTypeCubit extends Cubit<int> {
  TravelDocTypeCubit() : super(0);

  void setType(int newItem) {
    emit(newItem);
  }
}
