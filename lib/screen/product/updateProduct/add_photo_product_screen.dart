import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/product_img_service.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  final _imgSVC = new ImageService();
  File _image;
  final ImagePicker picker = ImagePicker();
  Future getImage({@required bool gallery}) async {
    XFile img = await picker.pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      if (img != null) _image = File(img.path);
      if (img == null) print('No image selected.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final String email = authService.user.email;
    Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}', style: TextStyle(color: Colors.white)),
        actions: [
          _image == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () => sendImage(product: product, email: email),
                ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: _image == null
                  ? Text('Ninguna imagen seleccionada o tomada.')
                  : Image.file(_image),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButtom(
                title: 'Galeria',
                onPressed: () => getImage( gallery: true)
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage( gallery: false ),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
        // isExtended: true,
      ),
    );
  }

  sendImage({@required Product product, String email}) async {
    if (_image.path.isEmpty) return print('Image is null');
    print('Sending image...');
    List bytes = await _image.readAsBytes();
    String img64 = base64.encode(bytes);
    bool resp = await _imgSVC.addNewProductImage(data: {
      'user': email,
      'uid': product.id,
      'img': img64,
    });
    // final StorageReference ref = FirebaseStorage.instance.ref().child('image.jpg');
    print('Sending image');
    resp ? print('Image sent') : print('Image not sent');
    Navigator.pop(context);
  }
}
