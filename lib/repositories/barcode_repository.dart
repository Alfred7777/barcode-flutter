import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeRepository {
  Future<List<Barcode>> getBarcodes() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> _barcodeStringList = [];
    if (prefs.containsKey('barcodes')) {
      _barcodeStringList = prefs.getStringList('barcodes') ?? [];
    }

    List<Barcode> _barcodeList = List<Barcode>.from(
      _barcodeStringList.map((barcodeString) {
        var barcodeJson = jsonDecode(barcodeString);
        return Barcode.fromJson(barcodeJson);
      }),
    );

    return _barcodeList;
  }

  Future<void> addBarcode(Barcode barcode) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> _barcodeStringList = [];
    if (prefs.containsKey('barcodes')) {
      _barcodeStringList = prefs.getStringList('barcodes') ?? [];
    }

    var _barcodeString = jsonEncode(barcode);
    _barcodeStringList.add(_barcodeString);

    prefs.setStringList('barcodes', _barcodeStringList);
  }

  Future<void> removeBarcode(Barcode barcode) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> _barcodeStringList = [];
    if (prefs.containsKey('barcodes')) {
      _barcodeStringList = prefs.getStringList('barcodes') ?? [];
    }

    var _barcodeString = jsonEncode(barcode);
    _barcodeStringList.remove(_barcodeString);

    prefs.setStringList('barcodes', _barcodeStringList);
  }
}

class Barcode extends Equatable {
  final String id;
  final String code;
  final String creationDate;

  const Barcode({
    required this.id,
    required this.code,
    required this.creationDate,
  });

  factory Barcode.fromJson(Map<String, dynamic> json) {
    return Barcode(
      id: json['id'],
      code: json['code'],
      creationDate: json['creation_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'creation_date': creationDate,
    };
  }

  @override
  List<Object> get props => [id, code, creationDate];
}
