import 'package:equatable/equatable.dart';

class SelectableValue<T> extends Equatable {
  const SelectableValue({required this.value, required this.isSelected});

  final T value;
  final bool isSelected;

  @override
  List<Object?> get props => [value, isSelected];
}
