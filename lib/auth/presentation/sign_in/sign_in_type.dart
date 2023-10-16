import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_stage.dart';
import 'package:flutter/material.dart';

enum SignUserType implements Comparable<SignUserType> {
  enterprise(type: "Enterprise", sections: [
    EnterpriseStage(),
    EnterpriseAddressStage(),
    AvatarStage(),
    FinalStage()
  ]),

  personal(
      type: "Personal",
      sections: [PersonalStage(), AvatarStage(), FinalStage()]);

  final String type;
  final List<Widget> sections;

  const SignUserType({required this.type, required this.sections});

  static SignUserType getTypeOf(String? value) {
    if (value == null) {
      return SignUserType.personal;
    }

    return SignUserType.values.singleWhere((type) => type.name == value);
  }

  @override
  int compareTo(SignUserType other) {
    throw UnimplementedError();
  }
}
