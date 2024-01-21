import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_form.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class ChangeBucketNameView extends StatelessWidget {
  final String bucket;

  const ChangeBucketNameView({
    Key? key,
    required this.bucket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<ChangeBucketNameViewModel>(),
        child: ChangeBucketNameForm(
          bucket: bucket,
        ));
  }
}
