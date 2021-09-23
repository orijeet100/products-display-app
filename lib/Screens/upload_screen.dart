import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  late String productName='';
  late String description='';
  late String price='';
  late String URL='';
  late bool isFileUploaded=false;
  bool showSpinner=false;


  FirebaseStorage storage=FirebaseStorage.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  uploadImage() async
  {
    var originalImageSize;
    var compressedImageSize;
    final picker = ImagePicker();
    var image;
    var compressedImage;
    await Permission.photos.request();
    var permissionStatus=await Permission.photos.status;
    if(permissionStatus.isGranted)
      {
        image=await picker.pickImage(source: ImageSource.gallery);
        var file=File(image.path);
        print(image.path);
        compressedImage=await FlutterImageCompress.compressAndGetFile(image.path, '/data/user/0/com.example.applore/cache/image_picker113d4584962767765439.jpg',quality: 80);
        var fileNew=File(compressedImage.path);
        originalImageSize=file.lengthSync()* 0.000977;
        compressedImageSize=fileNew.lengthSync()* 0.000977;
        if(image!=null)
          {
            setState(() {
              showSpinner=true;
            });
            var snapshot=await storage.ref().child('folderName/$productName').putFile(fileNew);
            URL=await snapshot.ref.getDownloadURL();
            setState(() {
              showSpinner=false;
              isFileUploaded=true;
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //       content: Text('Size reduced from ${originalImageSize.toInt()} KB to ${compressedImageSize.toInt()} KB',
              //         style: TextStyle(
              //             fontSize:17
              //         ),
              //       ),
              //       action: SnackBarAction(onPressed: () {}, label: 'Close',
              //         textColor: Colors.yellow,
              //       ),
              //       duration: Duration(seconds: 5)
              //   ),
              // );
              Alert(
                context: context,
                type: AlertType.success,
                title: "Compression Complete",
                desc: "Size reduced from ${originalImageSize.toInt()} KB to ${compressedImageSize.toInt()} KB",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
            });
          }
        else
          {
            print('No path specified');
          }
      }
    else
      {
        print('grant permissions then try');
      }

  }

  post() async
  {
    final FirebaseFirestore firestore=FirebaseFirestore.instance;
    await firestore.collection("details").add(
        {
          'name':productName,
          'description':description,
          'price':price,
          'URL':URL,
          'timestamp':Timestamp.now()
        }
    );
  }

  TextEditingController textController1=TextEditingController();
  TextEditingController textController2=TextEditingController();
  TextEditingController textController3=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          actions: [
          ],
          elevation: 0,
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Colors.purple,
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                  child: TextFormField(
                    maxLength: 35,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value)
                    {
                      productName=value;
                    },
                    maxLines: null,
                    controller: textController1,
                    obscureText: false,
                    decoration: inputDecoration.copyWith(hintText: 'Name of the product'),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF303030),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 30),
                  child: TextFormField(
                    maxLength: 200,
                      textCapitalization: TextCapitalization.sentences,
                    onChanged: (value)
                    {
                      description=value;
                    },
                    maxLines: null,
                    controller: textController2,
                    obscureText: false,
                    decoration: inputDecoration.copyWith(hintText: 'Description '),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF303030),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 30),
                  child: TextFormField(
                    maxLength: 10,
                    onChanged: (value)
                    {
                      price=value;
                    },
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    controller: textController3,
                    obscureText: false,
                    decoration: inputDecoration.copyWith(hintText: 'Price'),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF303030),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.2,vertical:20 ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async{

                          if(productName!='' && description!='' && price!='')
                            {
                              if(price=='0')
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Price can\'t be 0 please enter accurate value',
                                          style: TextStyle(
                                              fontSize:17
                                          ),
                                        ),
                                        action: SnackBarAction(onPressed: () {}, label: 'Close',
                                          textColor: Colors.yellow,
                                        ),
                                        duration: Duration(seconds: 3)
                                    ),
                                  );
                                }
                              else
                                {
                                  uploadImage();
                                }

                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Fill all other details first',
                                      style: TextStyle(
                                          fontSize:17
                                      ),
                                    ),
                                    action: SnackBarAction(onPressed: () {}, label: 'Close',
                                      textColor: Colors.yellow,
                                    ),
                                    duration: Duration(seconds: 3)
                                ),
                              );
                            }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Compress and upload an image',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.upload_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(child: Text(isFileUploaded?'Image Uploaded ✔ ':'No Image uploaded ❌',style: TextStyle(
                  fontSize: 17,color: Colors.white
                ),)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3,vertical: 60 ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async{
                          if(productName!='' && description!='' && price!='')
                          {
                            if(price=='0')
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Price can\'t be 0 please enter accurate value',
                                      style: TextStyle(
                                          fontSize:17
                                      ),
                                    ),
                                    action: SnackBarAction(onPressed: () {}, label: 'Close',
                                      textColor: Colors.yellow,
                                    ),
                                    duration: Duration(seconds: 3)
                                ),
                              );
                            }
                            else
                            {
                              if(URL=='')
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Please upload an image',
                                          style: TextStyle(
                                              fontSize:17
                                          ),
                                        ),
                                        action: SnackBarAction(onPressed: () {}, label: 'Close',
                                          textColor: Colors.yellow,
                                        ),
                                        duration: Duration(seconds: 3)
                                    ),
                                  );
                                }
                              else
                                {
                                  await post();
                                  Navigator.pop(context);
                                }
                            }

                          }
                          else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Fill all other details first',
                                    style: TextStyle(
                                        fontSize:17
                                    ),
                                  ),
                                  action: SnackBarAction(onPressed: () {}, label: 'Close',
                                    textColor: Colors.yellow,
                                  ),
                                  duration: Duration(seconds: 3)
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Post',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.post_add,
                                color: Colors.black,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
