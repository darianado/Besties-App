import 'package:faker/faker.dart';

// This class is purely used so that the feed and ProfileContainer Widget
// are easily refactorable once we link the project with the database.
// This file will be deleted.
class Profile {
  final int seed;
  final Faker faker;
  late String firstName;
  late String lastName;
  late String continent;

  Profile({required this.seed}) : faker = Faker(seed: seed) {
    firstName = faker.person.firstName();
    lastName = faker.person.lastName();
    continent = faker.address.continent();
  }
}
