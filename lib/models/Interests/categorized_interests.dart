import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';

class CategorizedInterests {
  final List<Category> categories;

  CategorizedInterests({required this.categories});

  factory CategorizedInterests.fromList(List<dynamic> list) {
    final categories = list.map((e) => Category.fromMap(e)).toList();
    return CategorizedInterests(categories: categories);
  }

  List<Map<String, dynamic>> toList() {
    return categories.map((e) => e.toMap()).toList();
  }

  List<Interest> get flattenedInterests {
    return categories.map((category) => category.interests).expand((i) => i).toList();
  }

  int numberOfInterestsInCommonWith(CategorizedInterests? other) {
    if (other == null) return 0;

    final _ownFlattenedInterestsAsStrings = flattenedInterests.map((Interest interest) => interest.title.toLowerCase()).toSet();
    final _otherFlattenedInterestsAsStrings = other.flattenedInterests.map((Interest interest) => interest.title.toLowerCase()).toSet();
    final _intersection = _ownFlattenedInterestsAsStrings.intersection(_otherFlattenedInterestsAsStrings);

    return _intersection.length;
  }

  CategorizedInterests filter(CategorizedInterests other) {
    final newCategories = categories.where((Category category) {
      int _filterCategoryIndex =
          other.categories.indexWhere((Category filterCategory) => filterCategory.title.toLowerCase() == category.title.toLowerCase());

      if (_filterCategoryIndex == -1) return false;

      category.interests.where((Interest interest) {
        int _filterInterestIndex = other.categories
            .elementAt(_filterCategoryIndex)
            .interests
            .indexWhere((Interest filterInterest) => filterInterest.title.toLowerCase() == interest.title.toLowerCase());

        return (_filterInterestIndex != -1);
      });

      return true;
    }).toList();

    return CategorizedInterests(categories: newCategories);
  }

  CategorizedInterests addMissing(CategorizedInterests other) {
    List<Category> newCategories = categories;

    for (var otherCategory in other.categories) {
      int _otherCategoryIndex =
          categories.indexWhere((Category category) => otherCategory.title.toLowerCase() == category.title.toLowerCase());

      if (_otherCategoryIndex == -1) {
        newCategories.add(Category(title: otherCategory.title, interests: []));
      }
    }

    return CategorizedInterests(categories: newCategories);
  }

  Category getCorrespondingCategory(Category other) {
    return categories.singleWhere((Category category) => category.title.toLowerCase() == other.title.toLowerCase(),
        orElse: () => Category(title: other.title, interests: []));
  }

  void replaceCorrespondingCategory(Category other) {
    int index = categories.indexWhere((Category element) => element.title.toLowerCase() == other.title.toLowerCase());
    if (index != -1) {
      categories[index] = other;
    }
  }

  @override
  bool operator ==(other) {
    if (other is CategorizedInterests) {
      List<String> _interests = flattenedInterests.map((Interest interest) => interest.title).toList();
      List<String> _otherInterests = other.flattenedInterests.map((Interest interest) => interest.title).toList();

      _interests.sort();
      _otherInterests.sort();

      return _interests.join(",") == _otherInterests.join(",");
    } else {
      return false;
    }
  }

  @override
  // Need to have this here for consistency. Not using in our current app.
  int get hashCode => super.hashCode ^ categories.length;
}
