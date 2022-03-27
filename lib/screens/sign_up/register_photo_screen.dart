import 'dart:io';
import 'package:project_seg/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/cached_image.dart';

import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';

import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:project_seg/utility/pick_image.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';

class RegisterPhotoScreen extends StatefulWidget {
  RegisterPhotoScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  State<RegisterPhotoScreen> createState() => _RegisterPhotoScreenState();
}

class _RegisterPhotoScreenState extends State<RegisterPhotoScreen> {
  final PickAndCropImage _pickAndCrop = PickAndCropImage();
  bool loadingPicture = false;

  String? validateProfileImageUrlError;

  void _pickImage(String uid) async {
    setState(() {
      loadingPicture = true;
    });

    String? url = await _pickAndCrop.pickImage(uid);

    widget.userData.profileImageUrl = url;

    setState(() {
      loadingPicture = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            foregroundColor: tertiaryColour,
            backgroundColor: whiteColour,
            expandedHeight: 120,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed(registerBasicInfoScreenName, extra: widget.userData),
              icon: buildIcons(Icons.arrow_back_ios, primaryColour),
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(leftRightPadding, 5, leftRightPadding, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Great! Now a photo...',
                        style: Theme.of(context).textTheme.headline4?.apply(color: secondaryColour, fontWeightDelta: 2),
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
                SizedBox(height: 20),
                SizedBox(
                  // height: 400,
                  child: Material(
                    child: (loadingPicture)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : InkWell(
                            onTap: () => _pickImage(_userState.user!.user!.uid),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  color: secondaryColour.withOpacity(0.2),
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
                                    borderRadius: circularBorderRadius10,
                                  ),
                                  height: 55,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buildIcons(Icons.photo, whiteColour),
                                      SizedBox(width: 10),
                                      Text(
                                        "EDIT",
                                        style: TextStyle(color: whiteColour),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                ValidatorError(errorText: validateProfileImageUrlError),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: PillButtonFilled(
                    text: "Next",
                    textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    onPressed: () {
                      if (!validate()) return;

                      context.goNamed(registerDescriptionScreenName, extra: widget.userData);
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

  bool validate() {
    setState(() {
      validateProfileImageUrlError = validateProfileImageUrl(widget.userData.profileImageUrl);
    });

    return (validateProfileImageUrlError == null);
  }
}
