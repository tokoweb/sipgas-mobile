import 'package:bloc/bloc.dart';

class LoadTubeTypeDriverCubit extends Cubit<int> {
  LoadTubeTypeDriverCubit() : super(0);

  void setType(int newItem) {
    emit(newItem);
  }
}
