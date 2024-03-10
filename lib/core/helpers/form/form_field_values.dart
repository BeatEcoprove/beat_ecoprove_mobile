enum FormFieldValues implements Comparable<FormFieldValues> {
  name(value: "name"),
  phone(value: "phone"),
  bornDate(value: "bornDate"),
  userName(value: "userName"),
  email(value: "email"),
  country(value: "country"),
  gender(value: "gender"),
  street(value: "street"),
  locality(value: "locality"),
  postalCode(value: "postalCode"),
  port(value: "port"),
  avatar(value: "avatar"),
  password(value: "password"),
  typeOption(value: "typeOption"),
  confirmPassword(value: "confirmPassword"),
  clothName(value: "name"),
  clothType(value: "garmentType"),
  clothSize(value: "garmentSize"),
  clothBrand(value: "brand"),
  clothColor(value: "color"),
  clothImage(value: "clothAvatar"),
  groupName(value: "groupName"),
  groupDescription(value: "groupDescription"),
  groupIsPublic(value: "groupIsPublic"),
  groupPicture(value: "groupPicture"),
  profileName(value: "name"),
  profileBornDate(value: "bornDate"),
  profileGender(value: "gender"),
  profilePicture(value: "avatar"),
  profileUserName(value: "userName"),
  ecoCoins(value: "ecoCoins"),
  sustainablePoints(value: "sustainablePoints"),
  search(value: "search"),
  code(value: "code"),
  storeCountry(value: "storeCountry"),
  storeLocality(value: "storeLocality"),
  storeStreet(value: "storeStreet"),
  storePostalCode(value: "storePostalCode"),
  storeNumberPort(value: "storeNumberPort");

  final String value;
  const FormFieldValues({required this.value});

  @override
  int compareTo(FormFieldValues other) {
    throw UnimplementedError();
  }
}
