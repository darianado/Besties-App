// Widget that displays all of the profile's details as a sliding bottom sheet.
import 'package:flutter/cupertino.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:project_seg/constants/colours.dart';
import '../../models/User/UserData.dart';
import 'buttons/bio_field.dart';
import 'buttons/edit_dob_button.dart';
import 'buttons/gender_button.dart';
import 'buttons/relationship_status_button.dart';
import 'buttons/university_button.dart';

class SlidingProfileDetails extends StatefulWidget {
  final UserData profile;
  final String? commonInterests;

  const SlidingProfileDetails(
      {Key? key, required this.profile, this.commonInterests})
      : super(key: key);

  @override
  State<SlidingProfileDetails> createState() => _SlidingProfileDetailsState();
}

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

  Future<dynamic> _scrollBackToTop(details) async {
    await controller.scrollToIndex(0,
        duration: const Duration(milliseconds: 500),
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.43,
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
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      widget.profile.fullName ?? " ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kTertiaryColour,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    UniversityButton(
                      label: widget.profile.university ?? " ",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    BioField(
                      label: widget.profile.bio ?? " ",
                      editable: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "YOU HAVE ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: kPrimaryColour.withOpacity(0.3),
                          ),
                        ),
                        Text(
                          widget.commonInterests ?? "NO",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: kTertiaryColour,
                          ),
                        ),
                        widget.commonInterests == "1"
                            ? Text(
                                " INTEREST IN COMMON!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: kPrimaryColour.withOpacity(0.3),
                                ),
                              )
                            : Text(
                                " INTERESTS IN COMMON!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: kPrimaryColour.withOpacity(0.3),
                                ),
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
