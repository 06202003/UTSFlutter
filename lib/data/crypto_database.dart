import 'dart:async';
import 'dart:math';

class Cryptobase {
  static double _bitcoin = 34596;
  static double _ethereum = 1816;
  static Timer? _timer;
  static Cryptobase? _instance;

  static final Random _random = Random();

  Cryptobase._();

  static void initialize() {
    _timer ??= Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateCrypto();
      _timer = timer;
    });
  }

  static Cryptobase get instance {
    _instance ??= Cryptobase._();

    return _instance!;
  }

  Stream<double> getPriceStream(Crypto crypto) => Stream.periodic(
      const Duration(seconds: 3),
      (_) => switch (crypto) {
            Crypto.bitcoin => _bitcoin,
            Crypto.ethereum => _ethereum,
          });

  double getPrice(Crypto crypto) {
    switch (crypto) {
      case Crypto.bitcoin:
        return _bitcoin;
      case Crypto.ethereum:
        return _ethereum;
    }
  }

  static void _updateCrypto() {
    _bitcoin += _random.nextDouble() * 10 * (_random.nextBool() ? 1 : -1);
    _ethereum += _random.nextDouble() * 10 * (_random.nextBool() ? 1 : -1);
  }
}

enum Crypto {
  bitcoin,
  ethereum,
}
