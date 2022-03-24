// Widget that displays all of the profile's details as a sliding bottom sheet.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../models/User/UserData.dart';
import 'buttons/bio_field.dart';
import 'buttons/edit_dob_button.dart';
import 'buttons/gender_button.dart';
import 'buttons/relationship_status_button.dart';
import 'buttons/university_button.dart';

/// The Widget that shows the displayed profile's complete details.
///
/// The Widget is built upon tapping the [ProfileContainer]'s [PartialProfileDetails]
/// as a modal bottom sheet.
/// It is composed of the profile's full name, university, age, gender,
/// relationship status and bio.
class SlidingProfileDetails extends StatefulWidget {
  final UserData profile;
  final String? commonInterests;

  const SlidingProfileDetails(
      {Key? key, required this.profile, this.commonInterests})
      : super(key: key);

  @override
  State<SlidingProfileDetails> createState() => _SlidingProfileDetailsState();
}

/// The State for the [SlidingProfileDetails] widget.
class _SlidingProfileDetailsState extends State<SlidingProfileDetails> {
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  /// Scrolls the information back to the top of the modal bottom sheet.
  Future<dynamic> _scrollBackToTop(details) async {
    await controller.scrollToIndex(0,
        duration: const Duration(milliseconds: 500),
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.46,
      child: Listener(
        onPointerUp: (details) => _scrollBackToTop(details),
        child: ListView(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: const ClampingScrollPhysics(),
          children: [
            AutoScrollTag(
              key: const ValueKey(0),
              index: 0,
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(leftRightPadding),
                child: Column(
                  children: [
                    Text(
                      widget.profile.fullName ?? " ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.apply(color: kTertiaryColour, fontWeightDelta: 2),
                    ),
                    const SizedBox(height: 15),
                    UniversityButton(
                      label: widget.profile.university ?? " ",
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        DateOfBirthButton(
                            label: (widget.profile.age ?? " ").toString()),
                        GenderButtton(label: widget.profile.gender ?? " "),
                        RelationshipStatusButton(
                            label: widget.profile.relationshipStatus ?? " "),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BioField(
                      label: widget.profile.bio ?? " ",
                      editable: false,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "YOU HAVE ",
                          style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: kSecondaryColour.withOpacity(0.3),
                              fontWeightDelta: 2),
                        ),
                        Text(
                          widget.commonInterests ?? "NO",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.apply(fontWeightDelta: 5),
                        ),
                        widget.commonInterests == "1"
                            ? Text(
                                " INTEREST IN COMMON!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(
                                        color:
                                            kSecondaryColour.withOpacity(0.3),
                                        fontWeightDelta: 2),
                              )
                            : Text(
                                " INTERESTS IN COMMON!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(
                                        color:
                                            kSecondaryColour.withOpacity(0.3),
                                        fontWeightDelta: 2),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
