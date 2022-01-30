import 'dart:io';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> isConnected() async {
    var response = await InternetAddress.lookup('www.google.com');

    if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
