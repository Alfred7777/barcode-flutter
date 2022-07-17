import 'package:bloc/bloc.dart';
import 'barcode_event.dart';
import 'barcode_state.dart';
import 'package:barcode_reader/repositories/barcode_repository.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  final BarcodeRepository barcodeRepository;

  BarcodeBloc({
    required this.barcodeRepository,
  }) : super(BarcodeUninitialized()) {
    on<FetchBarcodes>((event, emit) async {
      emit(BarcodeLoading());
      try {
        var _barcodeList = await barcodeRepository.getBarcodes();

        emit(
          BarcodeReady(
            barcodeList: _barcodeList,
          ),
        );
      } catch (exception) {
        emit(
          const BarcodeError(
            error: 'Wczytanie listy barkodów nie powiodło się!',
          ),
        );
      }
    });

    on<AddBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        await barcodeRepository.addBarcode(
          event.barcode,
        );
        var _barcodeList = await barcodeRepository.getBarcodes();

        emit(
          BarcodeReady(
            barcodeList: _barcodeList,
          ),
        );
      } catch (exception) {
        emit(
          const BarcodeError(
            error: 'Zapisanie barkodu nie powiodło się!',
          ),
        );
      }
    });

    on<RemoveBarcode>((event, emit) async {
      emit(BarcodeLoading());
      try {
        await barcodeRepository.removeBarcode(
          event.barcode,
        );
        var _barcodeList = await barcodeRepository.getBarcodes();

        emit(
          BarcodeReady(
            barcodeList: _barcodeList,
          ),
        );
      } catch (exception) {
        emit(
          const BarcodeError(
            error: 'Usunięcie zapisanego barkodu nie powiodło się!',
          ),
        );
      }
    });
  }
}
