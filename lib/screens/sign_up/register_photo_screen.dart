import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/screens/home/profile/components/cached_image.dart';
import 'package:project_seg/services/storage_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class RegisterPhotoScreen extends StatefulWidget {
  RegisterPhotoScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  State<RegisterPhotoScreen> createState() => _RegisterPhotoScreenState();
}

class _RegisterPhotoScreenState extends State<RegisterPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  bool loadingPicture = false;
  bool couldNotValidatePhotoSelection = false;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    void pickImage() async {
      XFile? file = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800, imageQuality: 90);
      if (file == null) return;

      setState(() {
        loadingPicture = true;
      });

      File? f = File(file.path);
      f = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
        aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      );
      String? url = await StorageService.instance.changeUserPhoto(_userState.user!.user!.uid, f);

      setState(() {
        widget.userData.profileImageUrl = url;
        loadingPicture = false;
      });
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            foregroundColor: kTertiaryColour,
            backgroundColor: Colors.white,
            expandedHeight: 150,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed("register_basic_info", extra: widget.userData),
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColour,
              ),
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Great! Now a photo...',
                        style: TextStyle(
                          fontSize: 29.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColour,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    height: 400,
                    child: Material(
                      child: (loadingPicture)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : InkWell(
                              onTap: () => pickImage(),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: (widget.userData.profileImageUrl != null)
                                        ? CachedImage(url: widget.userData.profileImageUrl)
                                        : Image.asset(
                                            "assets/images/empty_profile_picture.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "EDIT",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                (couldNotValidatePhotoSelection)
                    ? Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "You must select a photo",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.userData.profileImageUrl == null) {
                              setState(() {
                                couldNotValidatePhotoSelection = true;
                              });
                              return;
                            }
                            setState(() {
                              couldNotValidatePhotoSelection = false;
                            });

                            context.goNamed("register_description", extra: widget.userData);
                          },
                          child: Text("Next"),
                          style: ElevatedButton.styleFrom(
                            primary: kTertiaryColour,
                            onPrimary: kWhiteColour,
                            fixedSize: const Size(300, 100),
                            shadowColor: kTertiaryColour,
                            elevation: 12,
                            textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
