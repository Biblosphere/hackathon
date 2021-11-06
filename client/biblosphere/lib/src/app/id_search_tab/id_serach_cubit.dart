import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdSearchState extends Equatable {
  const IdSearchState({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

class IdSearchCubit extends Cubit<IdSearchState> {
  IdSearchCubit() : super(const IdSearchState(id: ''));

  void onIdChanged(String id) {
    emit(IdSearchState(id: id.replaceAll(' ', '')));
  }
}
