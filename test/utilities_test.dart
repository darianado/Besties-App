import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/utility/auth_exception_handler.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:project_seg/utility/helpers.dart';
import 'package:project_seg/utility/pick_image.dart';

void main() {
  group("Utilities:", () {
    group("Helpers:", () {
      test("Difference between two numbers", () {
        expect(difference(10, 2), -8);
        expect(difference(2, 2), 0);
        expect(difference(2, 10), 8);
        expect(difference(5, 5), isA<double>());
      });

      test("Icon for genders", () {
        expect(getIconForGender("MALE"), FontAwesomeIcons.mars);
        expect(getIconForGender("mALE"), FontAwesomeIcons.mars);
        expect(getIconForGender("male"), FontAwesomeIcons.mars);

        expect(getIconForGender("FEMALE"), FontAwesomeIcons.venus);
        expect(getIconForGender("feMale"), FontAwesomeIcons.venus);
        expect(getIconForGender("female"), FontAwesomeIcons.venus);

        expect(getIconForGender("NON-BINARY"), FontAwesomeIcons.venusMars);
        expect(getIconForGender("non-BINARY"), FontAwesomeIcons.venusMars);
        expect(getIconForGender("non-binary"), FontAwesomeIcons.venusMars);

        expect(getIconForGender("something else"), FontAwesomeIcons.venusMars);
      });
    });

    group("Form validators:", () {
      test("validateNotEmpty", () {
        expect(validateNotEmpty(null, "test"), isNotNull);
        expect(validateNotEmpty("", "test"), isNotNull);
        expect(validateNotEmpty(" ", "test"), isNull);
        expect(validateNotEmpty("some value", "test"), isNull);
      });

      test("validateEmail", () {
        expect(validateEmail(null), isNotNull);
        expect(validateEmail(""), isNotNull);
        expect(validateEmail(" "), isNotNull);
        expect(validateEmail("b@@g.com"), isNotNull);
        expect(validateEmail("b@gcom"), isNotNull);
        expect(validateEmail("b@g.com"), isNull);
        expect(validateEmail(".com"), isNotNull);
        expect(validateEmail("b@g"), isNotNull);
      });

      test("validatePassword", () {
        expect(validatePassword(null), isNotNull);
        expect(validatePassword(""), isNotNull);
        expect(validatePassword(" "), isNull);
        expect(validatePassword("some value"), isNull);
      });

      test("validateRepeatedPassword", () {
        expect(validateRepeatedPassword(null, null), isNotNull);
        expect(validateRepeatedPassword("pass", null), isNotNull);
        expect(validateRepeatedPassword("pass", "pass"), isNull);
        expect(validateRepeatedPassword(null, "pass"), isNotNull);
        expect(validateRepeatedPassword(" ", " "), isNull);
        expect(validateRepeatedPassword("", ""), isNotNull);
        expect(validateRepeatedPassword("abc", "bcd"), isNotNull);
      });

      test("validateExistsAndDifferentFrom", () {
        expect(validateExistsAndDifferentFrom(null, ""), isNotNull);
        expect(validateExistsAndDifferentFrom("pass", "hallo"), isNull);
        expect(validateExistsAndDifferentFrom("pass", "pass"), isNotNull);
        expect(validateExistsAndDifferentFrom(null, "pass"), isNotNull);
        expect(validateExistsAndDifferentFrom(" ", " "), isNotNull);
        expect(validateExistsAndDifferentFrom("", ""), isNotNull);
        expect(validateExistsAndDifferentFrom("abc", "bcd"), isNull);
      });

      test("validateRelationshipStatus", () {
        expect(validateRelationshipStatus(null), isNotNull);
        expect(validateRelationshipStatus(""), isNull);
        expect(validateRelationshipStatus(" "), isNull);
        expect(validateRelationshipStatus("some value"), isNull);
      });

      test("validateGender", () {
        expect(validateGender(null), isNotNull);
        expect(validateGender(""), isNull);
        expect(validateGender(" "), isNull);
        expect(validateGender("some value"), isNull);
      });

      test("validateDOB", () {
        expect(validateDOB(null), isNotNull);
        expect(validateDOB(DateTime.now()), isNull);
        expect(validateDOB(DateTime(1999, 1, 31)), isNull);
        expect(validateDOB(DateTime(2025, 1, 31)), isNull);
      });

      test("validateProfileImageUrl", () {
        expect(validateProfileImageUrl(null), isNotNull);
        expect(validateProfileImageUrl(""), isNull);
        expect(validateProfileImageUrl(" "), isNull);
        expect(validateProfileImageUrl("some value"), isNull);
      });

      test("validateBio", () {
        expect(validateBio(null), isNotNull);
        expect(validateBio(""), isNull);
        expect(validateBio(" "), isNull);
        expect(validateBio("some value"), isNull);
      });

      test("validateUniversity", () {
        expect(validateUniversity(null), isNotNull);
        expect(validateUniversity(""), isNull);
        expect(validateUniversity(" "), isNull);
        expect(validateUniversity("some value"), isNull);
      });

      test("validateInterests", () {
        expect(validateInterests(null, null, null), isNotNull);
        expect(validateInterests(null, 1, 20), isNotNull);
        expect(validateInterests(null, 20, 1), isNotNull);
        expect(validateInterests(CategorizedInterests(categories: []), 1, 20), isNotNull);
        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [],
                    )
                  ],
                ),
                1,
                20),
            isNotNull);
        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [
                        Interest(title: "sample interest"),
                      ],
                    )
                  ],
                ),
                1,
                20),
            isNull);

        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                      ],
                    )
                  ],
                ),
                1,
                3),
            isNotNull);

        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [
                        Interest(title: "sample interest"),
                      ],
                    ),
                    Category(
                      title: "sample2",
                      interests: [
                        Interest(title: "sample interest"),
                      ],
                    ),
                  ],
                ),
                1,
                3),
            isNull);

        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [
                        Interest(title: "sample interest"),
                      ],
                    ),
                    Category(
                      title: "sample2",
                      interests: [
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                      ],
                    ),
                  ],
                ),
                1,
                3),
            isNull);

        expect(
            validateInterests(
                CategorizedInterests(
                  categories: [
                    Category(
                      title: "sample",
                      interests: [
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                      ],
                    ),
                    Category(
                      title: "sample2",
                      interests: [
                        Interest(title: "sample interest"),
                        Interest(title: "sample interest"),
                      ],
                    ),
                  ],
                ),
                1,
                3),
            isNotNull);
      });
    });

    group("FirebaseAuthExceptionHandler", () {
      test("Ensure all known errors produce meaningful results", () {
        const String undefinedErrorString = "An undefined Error happened.";

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "invalid-email")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "wrong-password")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "user-not-found")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "user-disabled")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "too-many-requests")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "operation-not-allowed")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "email-already-in-use")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "weak-password")),
            isNot(undefinedErrorString));

        expect(AuthExceptionHandler.generateExceptionMessageFromException(FirebaseAuthException(code: "undefined-error")),
            undefinedErrorString);
      });
    });
  });
}
