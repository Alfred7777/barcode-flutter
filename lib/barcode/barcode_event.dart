import 'package:equatable/equatable.dart';
import 'package:barcode_reader/repositories/barcode_repository.dart';

class BarcodeEvent extends Equatable {
  const BarcodeEvent();

  @override
  List<Object> get props => [];
}

class FetchBarcodes extends BarcodeEvent {}

class AddBarcode extends BarcodeEvent {
  final Barcode barcode;

  const AddBarcode({
    required this.barcode,
  });
}
