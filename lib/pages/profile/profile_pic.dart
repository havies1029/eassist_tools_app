import 'dart:io';
import 'dart:typed_data';

import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eassist_tools_app/blocs/takeimage/takeimage_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eassist_tools_app/dao/user/user_dao.dart';
import 'dart:io' as io;

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  ProfilePicState createState() => ProfilePicState();
}

class ProfilePicState extends State<ProfilePic> {
  File? fileAvatar;
  Uint8List? bytesAvatar;

  Future<Uint8List> getBytesAvatar() async {
    //debugPrint("getBytesAvatar #10");
    UserDao dao = UserDao();
    Uint8List bytesAvatar = await dao.getUserFoto(0);

    //debugPrint(bytesAvatar.toString());

    //debugPrint("getBytesAvatar #20");

    return bytesAvatar;
  }

  Widget loadingWidget() {
    //debugPrint("loadingWidget #10");

    return FutureBuilder<Uint8List>(
      future: getBytesAvatar(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //debugPrint("snapshot berhasil");

          return Container(
              width: MediaQuery.of(context).size.width,
              height: 320,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: MemoryImage(snapshot.data!),
                fit: BoxFit.cover,
              )));

          //return Image.memory(snapshot.data!);
        } else if (snapshot.hasError) {
          //debugPrint("snapshot error");
          //debugPrint('${snapshot.error}');
          return const Center(
              child: Text('❌', style: TextStyle(fontSize: 72.0)));
        } else {
          //debugPrint("snapshot tidak jelas");
          return Container(
            //padding: EdgeInsets.all((widget.size - 50.0) / 2.0),
            padding: const EdgeInsets.all(20.0),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var takeImageCubit = BlocProvider.of<TakeImageCubit>(context);

    return Column(
      children: [
        Stack(
          children: [
            BlocBuilder<TakeImageCubit, TakeImageState>(
              builder: (context, state) {
                //debugPrint("Profile Pic => BlockBuilder #05");
                //debugPrint(state.toString());

                //print("BlocBuilder => TakeImageCubit");
                if ((state is SavedImageState) || (state is InitImageState)) {
                  //debugPrint("Profile Pic => BlockBuilder #10");
                  //debugPrint(state.toString());

                  //debugPrint("Profile Pic => BlockBuilder #20");

                  return loadingWidget();
                } else {
                  return Image.asset("assets/images/icon-user-default.png");
                }
              },
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: PopupMenuButton(
                  color: Colors.blueGrey,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //side: BorderSide(color: Colors.grey),
                  ),
                  onSelected: (value) async {
                    XFile? imageFile;

                    if (value == "camera") {
                      imageFile = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                          maxHeight: 200,
                          maxWidth: 200,
                          imageQuality: 70);
                    } else {
                      imageFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 200,
                          maxWidth: 200,
                          imageQuality: 70);
                    }

                    io.File file = io.File(imageFile!.path);
                    //print("Gallery: ${_imageFile!.path}");

                    takeImageCubit.setImageProfile(file);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'camera',
                      child: ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Camera',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'gallery',
                      child: ListTile(
                        leading: Icon(
                          Icons.photo_album,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Photo Gallery',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipOval(
                        clipper: IconCameraClip(),
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg")),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 5,
                width: 70,
                decoration: BoxDecoration(
                  color: HexColor("#E5E5E5"),
                  borderRadius: BorderRadius.circular(25),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class IconCameraClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: const Offset(0.0, 0.0), radius: 50.0);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class AvatarFotoClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: const Offset(0.0, 0.0), radius: 50.0);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
