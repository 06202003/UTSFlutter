import 'package:flutter/material.dart';
import '../../../../data/crypto_database.dart';
import 'dart:async';

class CryptoPage extends StatefulWidget {
  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  late Cryptobase _cryptobase;
  late StreamSubscription<double> _bitcoinStream;
  late StreamSubscription<double> _ethereumStream;

  double _bitcoinPrice = 0;
  double _ethereumPrice = 0;

  @override
  void initState() {
    super.initState();

    _cryptobase = Cryptobase.instance;
    _bitcoinStream = _cryptobase.getPriceStream(Crypto.bitcoin).listen((price) {
      setState(() {
        _bitcoinPrice = price;
      });
    });

    _ethereumStream =
        _cryptobase.getPriceStream(Crypto.ethereum).listen((price) {
      setState(() {
        _ethereumPrice = price;
      });
    });

    Cryptobase.initialize();
  }

  @override
  void dispose() {
    _bitcoinStream.cancel();
    _ethereumStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harga Crypto Hari Ini'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/bitcoin.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: CryptoPriceCard("Bitcoin", _bitcoinPrice),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/ethereum.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: CryptoPriceCard("Ethereum", _ethereumPrice),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CryptoPriceCard extends StatelessWidget {
  final String cryptoName;
  final double price;

  CryptoPriceCard(this.cryptoName, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              cryptoName,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
