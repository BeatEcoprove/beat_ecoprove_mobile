import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';

class AvatarStageViewModel extends FormViewModel {
  AvatarStageViewModel() {
    initializeFields([FormFieldValues.userName, FormFieldValues.avatar]);
    setValue(FormFieldValues.avatar, "assets/default_avatar.png");
    setValue(FormFieldValues.userName, "user_name");
  }

  void setUserName(String userName) {
    try {
      setValue<String>(
          FormFieldValues.userName, UserName.create(userName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.userName, e.message);
    }
  }
}
