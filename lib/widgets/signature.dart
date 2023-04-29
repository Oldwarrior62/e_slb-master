import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/comm/commHelper.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  SignatureScreen({Key? key}) : super(key: key);
  static const routeName = '/signature';

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  GlobalKey _key = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userProvider = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Signature"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          userProvider.state.signatureType == "LeftCursive"
              ? TextFormField(
                  key: Key("_textController"),
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Enter your text',
                  ),
                )
              : Signature(
                  key: Key("Signature"),
                  controller: _controller,
                  height: 300,
                  backgroundColor: Colors.lightBlueAccent,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  child: const Text("Clear"),
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_textController.text.isNotEmpty ||
                              _controller.isNotEmpty) {
                            Uint8List? data;
                            if (userProvider.state.signatureType == "Draw") {
                              data = await _controller.toPngBytes();
                            } else {
                              data = await _onPressedButton(
                                  _textController.text, userProvider);
                            }

                            if (data != null) {
                              if (userProvider.state.userModel == null) {
                                UserModel userModel = UserModel();

                                userModel.signature =
                                    String.fromCharCodes(data);
                                userProvider.setUser(userModel);
                              } else {
                                UserModel userModel = UserModel();
                                userModel.email =
                                    userProvider.state.userModel!.email;
                                userModel.image =
                                    userProvider.state.userModel!.image;
                                userModel.isLogin =
                                    userProvider.state.userModel!.isLogin;
                                userModel.name =
                                    userProvider.state.userModel!.name;
                                userModel.ofa =
                                    userProvider.state.userModel!.ofa;
                                userModel.ofaExpiryDate =
                                    userProvider.state.userModel!.ofaExpiryDate;
                                userModel.ofaLevel =
                                    userProvider.state.userModel!.ofaLevel;
                                userModel.password =
                                    userProvider.state.userModel!.password;
                                userModel.securityLicense = userProvider
                                    .state.userModel!.securityLicense;
                                userModel.securityLicenseExpiryDate =
                                    userProvider.state.userModel!
                                        .securityLicenseExpiryDate;
                                userModel.signature =
                                    userProvider.state.userModel!.signature;
                                userModel.surname =
                                    userProvider.state.userModel!.surname;
                                userModel.userId =
                                    userProvider.state.userModel!.userId;

                                userModel.signature =
                                    String.fromCharCodes(data);
                                userProvider.setUser(userModel);
                              }

                              alertDialog(context, "Signature Saved");
                            }
                          }
                        },
                        child: Text("Save")),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<Uint8List> getCanvasImage(String str, UserCubit user) async {
    var builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontFamily: "Cursiv", fontSize: 25));
    builder.pushStyle(ui.TextStyle(color: Colors.black));
    builder.addText(str);

    ui.Paragraph paragraph = builder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 100));

    final recorder = ui.PictureRecorder();
    var newCanvas = Canvas(recorder);

    newCanvas.drawParagraph(paragraph, Offset(10, 40));

    final picture = recorder.endRecording();
    var res = await picture.toImage(100, 100);
    ByteData? data = await res.toByteData(format: ui.ImageByteFormat.png);

    return Uint8List.view(data!.buffer);
  }

  Future<Uint8List> _onPressedButton(String text, UserCubit userCubit) async {
    return getCanvasImage(text, userCubit);
  }
}
