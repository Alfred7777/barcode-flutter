import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'barcode_bloc.dart';
import 'barcode_event.dart';
import 'barcode_state.dart';
import 'barcode_list.dart';
import 'barcode_scanner.dart';
import 'package:barcode_reader/repositories/barcode_repository.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<BarcodeScreen> createState() => BarcodeScreenState();
}

class BarcodeScreenState extends State<BarcodeScreen> {
  final barcodeRepository = BarcodeRepository();
  late BarcodeBloc _barcodeBloc;

  @override
  void initState() {
    super.initState();
    _barcodeBloc = BarcodeBloc(
      barcodeRepository: barcodeRepository,
    );
  }

  void _onAddBarcode(String barcodeCode) {
    DateFormat _dateFormat = DateFormat('dd.MM.yyyy');
    final _date = _dateFormat.format(DateTime.now());
    final _barcode = Barcode(
      id: const Uuid().v4(),
      code: barcodeCode,
      creationDate: _date,
    );

    _barcodeBloc.add(
      AddBarcode(
        barcode: _barcode,
      ),
    );
  }

  void _onRemoveBarcode(Barcode barcode) {
    _barcodeBloc.add(
      RemoveBarcode(
        barcode: barcode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey.shade100,
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Lista Zapisanych Barkodów'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder(
              bloc: _barcodeBloc,
              builder: (context, state) {
                if (state is BarcodeUninitialized) {
                  _barcodeBloc.add(FetchBarcodes());
                }
                if (state is BarcodeReady) {
                  return BarcodeList(
                    barcodeList: state.barcodeList,
                    removeBarcode: _onRemoveBarcode,
                  );
                } else if (state is BarcodeError) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          state.error,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey.shade100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.grey.shade100,
                      ),
                    ]
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
              horizontal: 12.0,
            ),
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const BarcodeScanner();
                  }),
                );
                if (result != null) {
                  _onAddBarcode(result);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 16,
                    ),
                    child: Text(
                      'Zeskanuj barkod',
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.grey.shade100,
                      size: 32,
                    ),
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(54.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
