import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/utility/pick_image.dart';
import 'package:provider/provider.dart';

/// A widget that displays information about the user.
class ProfileInformation extends StatefulWidget {
  final UserData? userData;
  final bool editable;
  final Widget? leftAction;
  final Widget? rightAction;
  final Widget? onImageSection;
  final Widget? bottomSection;

  const ProfileInformation({
    Key? key,
    this.userData,
    required this.editable,
    this.onImageSection,
    this.leftAction,
    this.rightAction,
    this.bottomSection,
  }) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  bool loadingPicture = false;

  final PickAndCropImage _pickAndCrop = PickAndCropImage();
  late final FirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
  }

  /// Updates the user's profile picture.
  void _pickImage(String userID) async {
    setState(() {
      loadingPicture = true;
    });

    String? url = await _pickAndCrop.pickImage(userID);

    if (url != null) {
      _firestoreService.setProfileImageUrl(url, userID);
    }

    setState(() {
      loadingPicture = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColour,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: profileHeaderExtendedHeight,
            collapsedHeight: profileHeaderCollapsedHeight,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.leftAction != null) ? widget.leftAction! : Container(),
                (widget.rightAction != null)
                    ? widget.rightAction!
                    : Container(),
              ],
            ),
            flexibleSpace: (loadingPicture)
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : InkWell(
                    onTap: (widget.editable && widget.userData != null)
                        ? () => _pickImage(widget.userData!.uid!)
                        : null,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedImage(url: widget.userData?.profileImageUrl),
                        Column(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            (widget.onImageSection != null)
                                ? widget.onImageSection!
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    leftRightPadding, 15, leftRightPadding, 15),
                child: Column(
                  children: [
                    Text(
                      widget.userData?.fullName ?? "-",
                      style: Theme.of(context).textTheme.headline3?.apply(
                          fontWeightDelta: 2,
                          color: tertiaryColour
                              .withOpacity((widget.editable) ? 0.2 : 1)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    UniversityButton(
                      editable: widget.editable,
                      wiggling: widget.editable,
                      label: widget.userData?.university ?? "",
                      onSave: (university) =>
                          saveUniversity(widget.userData?.uid, university),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        DateOfBirthButton(label: "${widget.userData?.age}"),
                        GenderButton(
                          editable: widget.editable,
                          wiggling: widget.editable,
                          label: widget.userData?.gender ?? "",
                          onSave: (gender) =>
                              saveGender(widget.userData?.uid, gender),
                        ),
                        RelationshipStatusButton(
                          editable: widget.editable,
                          wiggling: widget.editable,
                          label: widget.userData?.relationshipStatus ?? "",
                          onSave: (relationshipStatus) =>
                              saveRelationshipStatus(
                                  widget.userData?.uid, relationshipStatus),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BioField(
                      label: widget.userData?.bio ?? " ",
                      editable: widget.editable,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "INTERESTS",
                          style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: secondaryColour.withOpacity(0.3),
                              fontWeightDelta: 3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DisplayInterests(
                      editable: widget.editable,
                      wiggling: widget.editable,
                      interests: widget.userData?.categorizedInterests ??
                          CategorizedInterests(categories: []),
                      onSave: (categorizedInterests) => saveInterests(
                          widget.userData?.uid, categorizedInterests),
                    ),
                    const SizedBox(height: 25),
                    (widget.bottomSection != null)
                        ? widget.bottomSection!
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Saves the user's date of birth.
  Future<void> saveDateOfBirth(String? userId, DateTime? dateOfBirth) async {
    if (userId != null && dateOfBirth != null) {
      await _firestoreService.setDateOfBirth(userId, dateOfBirth);
    }
  }

  /// Saves the user's relationship status.
  Future<void> saveRelationshipStatus(
      String? userId, String? relationshipStatus) async {
    if (userId != null && relationshipStatus != null) {
      await _firestoreService.setRelationshipStatus(userId, relationshipStatus);
    }
  }

  /// Saves the user's gender.
  Future<void> saveGender(String? userId, String? gender) async {
    if (userId != null && gender != null) {
      await _firestoreService.setGender(userId, gender);
    }
  }

  /// Saves the user's university.
  Future<void> saveUniversity(String? userId, String? university) async {
    if (userId != null && university != null) {
      await _firestoreService.setUniversity(userId, university);
    }
  }

  /// Saves the user's interests.
  Future<void> saveInterests(
      String? userId, CategorizedInterests? interests) async {
    if (userId != null && interests != null) {
      await _firestoreService.setInterests(userId, interests);
    }
  }
}
