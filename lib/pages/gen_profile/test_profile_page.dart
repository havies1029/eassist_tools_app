import 'dart:typed_data';

import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_download_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_foto_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekancontactcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmpcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestProfilePage extends StatefulWidget {
  const TestProfilePage({super.key});

  @override
  State<TestProfilePage> createState() => _TestProfilePageState();
}

class _TestProfilePageState extends State<TestProfilePage> {    
  late MRekan1CrudBloc mRekan1CrudBloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    mRekan1CrudBloc = BlocProvider.of<MRekan1CrudBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<MRekan1CrudBloc, MRekan1CrudState>(
      builder: (context, state) {          
          return state.isLoaded ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),  
              child: Column(
                children: [
                  Text("Nama Client : ${state.record?.rekanNama ?? "????"}"),
                  Text("JenisClientId :${state.record?.mjnsclientId??"???"}"),
                  BlocBuilder<ProfileDownloadFotoBloc, ProfileDownloadFotoState>(
                    builder: (context, imageState) {
                      Uint8List? imageBytes;
                      if (imageState is ProfileDownloadFotoLoaded) {
                        imageBytes = imageState.imageBytes;
                      }

                      return ProfilePicture(
                        imageUrl: 'https://www.jayaproteksindo.co.id/image/Logo.png',
                        radius: 60,
                        blocImageBytes: imageBytes,
                        onImageSelected: (bytes, fileName) async {
                          context.read<ProfileUploadFotoBloc>().add(
                            UploadProfilePicture(bytes, fileName),
                          );
                        },
                      );
                    },
                  ),
                  MRekanGeneralCmpCrudFormPage(),
                  const SizedBox(height: 24),            
                  MRekanContactCrudFormPage(),
                  const SizedBox(height: 24),   
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ): CircularProgressIndicator();
        }, 
        listener: (BuildContext context, MRekan1CrudState state) {  },
      ),
    );
  }

void loadData() {
  context.read<ProfileDownloadFotoBloc>().add(LoadSecureImage());
  mRekan1CrudBloc.add(MRekan1CrudLihatEvent());
}

}