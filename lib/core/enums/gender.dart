enum Gender { Male, Female }

extension GenderExtension on Gender {
  String? get value {
    switch (this) {
      case Gender.Male:
        return 'M';
      case Gender.Female:
        return 'F';
      default:
        return null;
    }
  }

  String? get text {
    switch (this) {
      case Gender.Male:
        return 'Male';
      case Gender.Female:
        return 'Female';
      default:
        return null;
    }
  }
}
