import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}


class _CameraState extends State<Camera> {

//Rotas
 void nextPhase() async{
     Navigator.of(context).pushReplacementNamed('phase');
  }

  File? image;

  Future pickImage(ImageSource source) async {
    try{      
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    //final imageTemporary = File(image.path);
    final imagePermanent = await saveImagePermanently(image.path);
    setState(() => this.image = imagePermanent); 
    }on PlatformException catch (e) {
      print('falha na imagem: $e');
    }
  }  

  Future<File> saveImagePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
    backgroundColor: Colors.lightBlueAccent[100],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          image != null
           ? ClipOval(
             child:  
           Image.file(
             image!,
             width: 160,
             height: 160,
             fit: BoxFit.cover,
             ) )
             : Image.asset('lib/imagens/pacman.png'),
          const SizedBox(height: 24),
          Text (
          'Selecione a Imagem!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(          
            onPressed: () => pickImage(ImageSource.gallery),            
            child: const Icon(Icons.image_outlined),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => pickImage(ImageSource.camera),            
            child: const Icon(Icons.camera_alt_outlined),
          ),          
          const SizedBox(height: 24),
          ElevatedButton(
          onPressed: () => nextPhase(),
          child: const Icon(Icons.videogame_asset),         
          ),
          Spacer(),
      ],),
    ),
  );
}

  basename(String imagePath) {}
}