import 'dart:io';
import 'package:project_seg/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/services/storage_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';

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
      XFile? file = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 800,
          maxWidth: 800,
          imageQuality: 90);
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
      String? url = await StorageService.instance
          .changeUserPhoto(_userState.user!.user!.uid, f);

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
            backgroundColor: kWhiteColour,
            expandedHeight: 120,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed(registerBasicInfoScreenName,
                  extra: widget.userData),
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
                padding: const EdgeInsets.fromLTRB(
                    leftRightPadding, 5, leftRightPadding, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Great! Now a photo...',
                        style: Theme.of(context).textTheme.headline4?.apply(
                            color: kSecondaryColour, fontWeightDelta: 2),
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
                SizedBox(height: 40),
                SizedBox(
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
                                  child: (widget.userData.profileImageUrl !=
                                          null)
                                      ? CachedImage(
                                          url: widget.userData.profileImageUrl)
                                      : Image.asset(
                                          "assets/images/empty_profile_picture.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: kCircularBorderRadius10,
                                  ),
                                  height: 60,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo,
                                        color: kWhiteColour,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "EDIT",
                                        style: TextStyle(color: kWhiteColour),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                (couldNotValidatePhotoSelection)
                    ? Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "You must select a photo",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.apply(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: PillButtonFilled(
                    text: "Next",
                    backgroundColor: kTertiaryColour,
                    textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColour),
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

                      context.goNamed(registerDescriptionScreenName,
                          extra: widget.userData);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
