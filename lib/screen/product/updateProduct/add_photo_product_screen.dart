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
    XFile img = await picker.pickImage(
        source: gallery ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      if (img != null) _image = File(img.path);
      if (img == null) print('No image selected.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final String email = authService.user.email;
    final Product product = ModalRoute.of(context).settings.arguments;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('${product.name}', style: TextStyle(color: Colors.white)),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: _image == null
                ? Text('Ninguna imagen seleccionada o tomada.')
                : Image.file(
                  _image, 
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.scaleDown,
                  height: size.height * 0.5,
                ),
          ),
          _actionClickBtn(_image, product, email)
        ],
      ),
    );
  }

  _actionClickBtn(File img, Product product, String email) {
    if (img == null)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        children: [
          CustomButtom(
              title: 'Galeria', onPressed: () => getImage(gallery: true)),
          SizedBox( height: 10 ),
          CustomButtom(
              title: 'Camara', onPressed: () => getImage(gallery: false))
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: CustomButtom( title: 'Guardar', onPressed: () => sendImage(product: product, email: email),),
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
