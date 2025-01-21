import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_note_state.dart';

class SearchNoteCubit extends Cubit<String> {
  SearchNoteCubit() : super('');
  void updateKeyword( keyword) {
    emit(keyword); 
  }
}
