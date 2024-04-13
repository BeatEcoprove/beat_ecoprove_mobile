import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/selector_button/selector_button.dart';
import 'package:flutter/material.dart';

class SelectUserView extends LinearView<SelectUserViewModel> {
  static const double _topPadding = 200;
  static const double _bottomPadding = 100;
  static const double _horizontalPadding = 24;

  const SelectUserView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, SelectUserViewModel viewModel) {
    return Scaffold(
      body: GoBack(
        posTop: 48,
        posLeft: 22,
        child: ScrollHandler(
          topPadding: _topPadding,
          bottomPadding: _bottomPadding,
          leftPadding: _horizontalPadding,
          rightPadding: _horizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title
              Align(
                alignment: Alignment.center,
                child: Text(
                  LocaleContext.get().auth_select_user_type,
                  textAlign: TextAlign.center,
                  style: AppText.header,
                ),
              ),
              SelectorButton(
                selectors: [
                  LocaleContext.get().auth_select_user_personal_type,
                  LocaleContext.get().auth_select_user_enterprise_type
                ],
                onIndexChanged: (selectedIndex) =>
                    viewModel.setSelectionIndex(selectedIndex),
              ),
              FormattedButton(
                content: LocaleContext.get().auth_select_user_finish,
                textColor: Colors.white,
                onPress: () {
                  viewModel.handleSignIn();
                },
              ),
              // Footer
            ],
          ),
        ),
      ),
    );
  }
}
