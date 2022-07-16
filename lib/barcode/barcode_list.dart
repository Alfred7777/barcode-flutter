import 'package:flutter/material.dart';
import 'package:barcode_reader/repositories/barcode_repository.dart';

class BarcodeList extends StatelessWidget {
  final List<Barcode> barcodeList;

  const BarcodeList({
    Key? key,
    required this.barcodeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: barcodeList.length,
      itemBuilder: (context, index) {
        return BarcodeListElement(
          index: index,
          barcode: barcodeList[index],
        );
      },
    );
  }
}

class BarcodeListElement extends StatelessWidget {
  final int index;
  final Barcode barcode;

  const BarcodeListElement({
    Key? key,
    required this.index,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: index % 2 == 0 
          ? Colors.blueGrey.shade800 
          : Colors.blueGrey.shade900,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: BarcodeListElementText(
                text: barcode.code,
                fontSize: 20,
              ),
            ),
          ),
          BarcodeListElementText(
            text: barcode.creationDate,
            fontSize: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.close,
                  size: 20,
                ),
                style: TextButton.styleFrom(
                  primary: Colors.grey.shade100,
                  backgroundColor: Colors.red.shade600,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(54.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarcodeListElementText extends StatelessWidget {
  final String text;
  final double fontSize;

  const BarcodeListElementText({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade100,
        fontFamily: 'Poppins',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
