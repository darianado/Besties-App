enum Gender { male, female, other }

String genderLabel(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "MALE";
    case Gender.female:
      return "FEMALE";
    case Gender.other:
      return "OTHER";
  }
}
