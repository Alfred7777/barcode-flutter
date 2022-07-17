import 'package:equatable/equatable.dart';
import 'package:barcode_reader/repositories/barcode_repository.dart';

class BarcodeState extends Equatable {
  const BarcodeState();

  @override
  List<Object> get props => [];
}

class BarcodeUninitialized extends BarcodeState {}

class BarcodeLoading extends BarcodeState {}

class BarcodeReady extends BarcodeState {
  final List<Barcode> barcodeList;

  const BarcodeReady({
    required this.barcodeList,
  });

  @override
  List<Object> get props => [barcodeList];
}

class BarcodeError extends BarcodeState {
  final String error;

  const BarcodeError({required this.error});

  @override
  List<Object> get props => [error];
}
