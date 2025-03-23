import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/data/network/app_requests/wir_requests.dart';
import 'package:teqani/data/responses/main/form/preview_file/preview_file_response.dart';

import 'module.dart';

class OpenFile{
  final GraphQLClient _client = AppServiceClient.instance.getAppClient(false);

  void openFile(String transactionId){
    _getFileData(transactionId);
  }

  void _getFileData(String transactionId) async {
    final QueryOptions options = QueryOptions(
      document: gql(WirRequests.previewWIR),
      variables: {
        "transaction_id": transactionId,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print('Error: ${result.exception.toString()}');
    } else {
      final data = result.data;
      print('File data: $data');
      PreviewFileResponse response = PreviewFileResponse.fromJson(data ?? {});
      _getFile(
          response.previewWirTransaction!.data!.fileName ?? '',
          response.previewWirTransaction!.data!.content ?? ''
      );
    }
  }

  void getBase64File(String filePath) async {
    try{
      var response = await Dio().get(filePath);
      print('Response: $response');
      if (response.statusCode == 200) {
        print('Success: ${response.statusCode}');
        print('Success base64: ${response.data['base64']}');
        String base64String = response.data['base64'].toString();
        _getFile('file.pdf', base64String);
      } else {
        print('Error: ${response.statusCode}');
        print('Error: ${response.statusMessage}');
        print('Error: ${response.data}');
        Module.showToast(
          'Something went wrong!!',
          true,
        );
      }
    }catch(e){
      print('Error: $e');
      Module.showToast(
        'Something went wrong!!',
        true,
      );
    }
  }

  void _getFile(String fileName, String content) async {

    try {
      // Decode Base64 to bytes
      final decodedBytes = base64Decode(content);

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a temporary file
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);

      // Write the decoded bytes to the file
      await file.writeAsBytes(decodedBytes);

      // Set the file in the state
      await OpenFilex.open(file.path);

    } catch (e) {
      print("Error opening PDF: $e");
    }
  }

}