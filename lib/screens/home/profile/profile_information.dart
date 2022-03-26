import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/pick_image.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  final bool editable;
  final Widget? leftAction;
  final Widget? rightAction;
  final Widget? bottomSection;

  ProfileInformation({Key? key, required this.editable, this.leftAction, this.rightAction, this.bottomSection}) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  bool loadingPicture = false;

  final PickAndCropImage _pickAndCrop = PickAndCropImage();
  final FirestoreService _firestoreService = FirestoreService.instance;

  void _pickImage(String uid) async {
    setState(() {
      loadingPicture = true;
    });

    String? url = await _pickAndCrop.pickImage(uid);

    if (url != null) {
      FirestoreService.instance.setProfileImageUrl(url);
    }

    setState(() {
      loadingPicture = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    //const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 350;
    const double profileHeaderCollapsedHeight = 220;

    return Scaffold(
      backgroundColor: whiteColour,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: profileHeaderExtendedHeight,
            collapsedHeight: profileHeaderCollapsedHeight,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            backgroundColor: Colors.transparent,
            leading: widget.leftAction,
            actions: [
              (widget.rightAction != null) ? widget.rightAction! : Container(),
            ],
            flexibleSpace: (loadingPicture)
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : InkWell(
                    onTap: () => _pickImage(_userState.user!.user!.uid),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedImage(url: _userState.user?.userData?.profileImageUrl),
                        (widget.editable)
                            ? Column(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Container(
                                    color: opacBlack,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "EDIT",
                                      style: Theme.of(context).textTheme.bodyMedium?.apply(color: whiteColour),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(left: leftRightPadding, right: leftRightPadding, bottom: 15),
              child: Column(
                children: [
                  Text(
                    _userState.user?.userData?.fullName ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.apply(fontWeightDelta: 2, color: tertiaryColour.withOpacity((widget.editable) ? 0.2 : 1)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  UniversityButton(
                    editable: widget.editable,
                    wiggling: widget.editable,
                    label: _userState.user?.userData?.university ?? "",
                    onSave: (university) => saveUniversity(_userState.user?.user?.uid, university),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      DateOfBirthButton(label: "${_userState.user?.userData?.age}"),
                      GenderButtton(
                        editable: widget.editable,
                        wiggling: widget.editable,
                        label: _userState.user?.userData?.gender ?? "",
                        onSave: (gender) => saveGender(_userState.user?.user?.uid, gender),
                      ),
                      RelationshipStatusButton(
                        editable: widget.editable,
                        wiggling: widget.editable,
                        label: _userState.user?.userData?.relationshipStatus ?? "",
                        onSave: (relationshipStatus) => saveRelationshipStatus(_userState.user?.user?.uid, relationshipStatus),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BioField(
                    label: _userState.user?.userData?.bio ?? " ",
                    editable: widget.editable,
                  ),
                  SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "INTERESTS",
                        style: Theme.of(context).textTheme.bodyMedium?.apply(color: secondaryColour.withOpacity(0.3), fontWeightDelta: 3),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  DisplayInterests(
                    editable: widget.editable,
                    wiggling: widget.editable,
                    items: _userState.user?.userData?.categorizedInterests?.flattenedInterests ?? [],
                    onSave: (categorizedInterests) {
                      saveInterests(_userState.user?.user?.uid, categorizedInterests);
                    },
                  ),
                  SizedBox(height: 25),
                  (widget.bottomSection != null) ? widget.bottomSection! : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveDateOfBirth(String? userId, DateTime? dateOfBirth) async {
    if (userId != null && dateOfBirth != null) {
      await _firestoreService.setDateOfBirth(userId, dateOfBirth);
    }
  }

  Future<void> saveRelationshipStatus(String? userId, String? relationshipStatus) async {
    if (userId != null && relationshipStatus != null) {
      await _firestoreService.setRelationshipStatus(userId, relationshipStatus);
    }
  }

  Future<void> saveGender(String? userId, String? gender) async {
    if (userId != null && gender != null) {
      await _firestoreService.setGender(userId, gender);
    }
  }

  Future<void> saveUniversity(String? userId, String? university) async {
    if (userId != null && university != null) {
      await _firestoreService.setUniversity(userId, university);
    }
  }

  Future<void> saveInterests(String? userId, CategorizedInterests? interests) async {
    if (userId != null && interests != null) {
      await _firestoreService.setInterests(userId, interests);
    }
  }
}
