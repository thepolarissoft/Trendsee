import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;

class GenerateImageUrl {
  bool success;
  String message;

  bool isGenerated;
  String uploadUrl;
  String downloadUrl;

  Future<void> call(String fileType) async {
    try {
      Map body = {"fileType": fileType};

      var response = await http.post(
        //For IOS
        Uri.parse('http://localhost:5000/generatePresignedUrl'),
        //For Android
        //'http://10.0.2.2:5000/generatePresignedUrl',
        body: body,
      );

      var result = jsonDecode(response.body);

      print(result);

      if (result['success'] != null) {
        success = result['success'];
        message = result['message'];

        if (response.statusCode == 201) {
          isGenerated = true;
          uploadUrl = result["uploadUrl"];
          downloadUrl = result["downloadUrl"];
        }
      }
    } catch (e) {
      throw ('Error getting url');
    }
  }
}


class UploadFile {
  bool success;
  String message;

  bool isUploaded;

  Future<void> call(String url, File image) async {
    try {
      var response = await http.put(Uri.parse(url), body: image.readAsBytesSync());
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
