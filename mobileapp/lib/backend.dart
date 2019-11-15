import 'dart:async';
import 'package:http/http.dart' as http;

const url = "https://protean-triode-257507.appspot.com/lab";

Future<String> req() async {
  final response = await http.get(url);
  return response.statusCode == 200
      ? response.body
      : throw Exception('Error: ${response.statusCode}');
}