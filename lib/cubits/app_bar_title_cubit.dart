import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarTitleCubit extends Cubit<String> {
  AppBarTitleCubit() : super("Home");

  void setTitle(String title) {
    emit(title);
  }
}
