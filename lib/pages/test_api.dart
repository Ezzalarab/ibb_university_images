import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibb_university_images/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// Future<http.Response> login(String username, String password) async {
//   return await http.post(
//     Uri.parse('http://10.4.179.1:8080/user/login'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'username': username,
//       'password': password,
//     }),
//   );
// }

// Future<http.StreamedResponse> sendImg(String filename, String url) async {
//   var request = http.MultipartRequest('POST', Uri.parse(url));

//   // request.files.add(http.MultipartFile('image',
//   //     File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
//   //     filename: filename.split("/").last));

//   request.fields.addAll({
//     "userID": "ezz",
//   });
//   request.files.add(http.MultipartFile.fromBytes(
//       'image', File(filename).readAsBytesSync(),
//       filename: filename.split("/").last));
//   var res = await request.send();
//   return res;
// }

class TestApi extends StatefulWidget {
  const TestApi({Key? key}) : super(key: key);

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  @override
  Widget build(BuildContext context) {
    var _coords;
    Future<void> getStaticMapCoordinates(String address) async {
      if (address.isEmpty) {
        return;
      }
      final http.Response response = await http.get(
        Uri.parse(
            'https://www.mapquestapi.com/geocoding/v1/address?key=[APIKEY]&inFormat=kvp&outFormat=json&location=${address}&thumbMaps=false&maxResults=1'),
      );

      final decodedResponse = json.decode(response.body);
      setState(() {
        _coords = decodedResponse['results'][0]['locations'][0]['latLng'];
      });
    }

    Widget _buildStaticMapImage() {
      if (_coords == null) {
        return Image.asset('assets/product.jpg');
      }
      return FadeInImage(
        image: NetworkImage(
            'https://www.mapquestapi.com/staticmap/v5/map?key=[APIKEY]&center=${_coords['lat']},${_coords['lng']}&zoom=13&type=hyb&locations=${_coords['lat']},${_coords['lng']}&size=500,300@2x'),
        placeholder: AssetImage('assets/product.jpg'),
      );
    }

    File? _image;
    PickedFile? _pickedFile;
    final _picker = ImagePicker();
    // Implementing the image picker
    Future<void> _pickImage() async {
      _pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        setState(() {
          _image = File(_pickedFile!.path);
        });
      }
    }

    Uint8List img = Uint8List.fromList([
      137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0,
      1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65,
      84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73,
      69, 78, 68, 174, 66, 96, 130 // prevent dartfmt
    ]);

    Future<Uint8List> tinypng() async {
      http.Response response = await http.get(
        Uri.parse('http://192.168.137.172:8080/testImage'),
      );

      print(jsonDecode(response.body)["data"]["data"]);
      // final bytes = Uint8List.fromList([
      //   137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0,
      //   1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65,
      //   84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73,
      //   69, 78, 68, 174, 66, 96, 130 // prevent dartfmt
      // ]);

      // // copy from decodeImageFromList of package:flutter/painting.dart
      // final codec = await instantiateImageCodec(bytes);
      // final frameInfo = await codec.getNextFrame();
      img = Uint8List.fromList(img);
      return img;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
      ),
      body: Center(
        child: Column(
          children: [
            MyTextField(
              label: "label",
              hint: "hint",
              keyBoardType: TextInputType.none,
              onChange: (value) {},
            ),
            ElevatedButton(
              child: Text("Send"),
              onPressed: () {
                // login("mohammed", "123567").then((res) {
                //   print(res.body);
                //   print("done");
                // });

                // _pickImage().then((value) {
                //   sendImg(_pickedFile!.path, "http://10.4.179.1:8080/upload")
                //       .then((res) {
                //     print(res);
                //   });
                //   print(_pickedFile!.path);
                // });

                // getStaticMapCoordinates(
                //         "http://10.4.179.1:8080/user/fetchAllCategories")
                //     .then((value) {
                //   setState(() {
                //     _buildStaticMapImage();
                //   });

                //   print("done");
                // });

                tinypng().then((value) {
                  setState(() {
                    img = base64Decode(value.toString());
                    ;
                  });
                });
              },
            ),
            Container(
              color: Colors.green,
              height: 400,
              width: 400,
              child: Image.memory(
                img,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
