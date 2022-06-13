import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ibb_university_images/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<http.Response> login(String username, String password) async {
  return await http.post(
    Uri.parse('http://10.4.179.1:8080/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
}

Future<http.StreamedResponse> sendImg(String filename, String url) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));

  // request.files.add(http.MultipartFile('image',
  //     File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
  //     filename: filename.split("/").last));

  request.fields.addAll({
    "userID": "ezz",
  });
  request.files.add(http.MultipartFile.fromBytes(
      'image', File(filename).readAsBytesSync(),
      filename: filename.split("/").last));
  var res = await request.send();
  return res;
}

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

    Widget img;

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

                getStaticMapCoordinates("http://10.4.179.1:8080/upload")
                    .then((value) {
                  _buildStaticMapImage();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
