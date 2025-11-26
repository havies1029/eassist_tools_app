import 'dart:typed_data';

import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_download_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_foto_bloc.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekancontactcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralcmpcrud_form.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekangeneralidvcrud_form.dart';
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
        debugPrint("TestProfilePage: state.isSetujuTC: ${state.isSetujuTC}");   
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
                  MRekanGeneralIdvCrudFormPage(),
                  const SizedBox(height: 24),  
                  Text("state.isSetujuTC : ${state.isSetujuTC}"),
                  if (!state.isSetujuTC) 
                    ElevatedButton(
                      onPressed: () {
                        mRekan1CrudBloc.add(MRekan1CrudSetujuTCEvent(mrekanId: state.record?.mrekan1Id ?? ""));
                      },
                      child: const Text('Setujui TC'),
                    ),
                ],
              ),
            ),
          ): CircularProgressIndicator();
        }, 
        listener: (BuildContext context, MRekan1CrudState state) {  },
        buildWhen: (previous, current) {
          return current.isSetujuTC || current.isLoaded;
        },
      ),
    );
  }

void loadData() {
  context.read<ProfileDownloadFotoBloc>().add(LoadSecureImage());
  mRekan1CrudBloc.add(MRekan1CrudLihatEvent());
}

}