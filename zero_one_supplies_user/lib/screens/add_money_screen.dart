import 'package:ecomik/controller/add_money_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMoneyScreenController>(
        init: AddMoneyScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .addMoneyTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top extra spaces
                      AppGaps.hGap15,
                      Text(
                          AppLanguageTranslation
                              .availableBalanceTransKey.toCurrentLanguage,
                          style:
                              const TextStyle(color: AppColors.bodyTextColor)),
                      AppGaps.hGap2,
                      Text(r'$ 278.98',
                          style: Theme.of(context).textTheme.displayMedium),
                      AppGaps.hGap24,
                      Text(
                          AppLanguageTranslation
                              .bankInformationTransKey.toCurrentLanguage,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: AppColors.primaryColor)),
                      AppGaps.hGap16,
                      /* <---- Account holder name text field ----> */
                      CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .accountHolderNameTransKey.toCurrentLanguage,
                          hintText: 'George Anderson',
                          prefixIcon: AppGaps.emptyGap),
                      AppGaps.hGap24,
                      /* <---- Bank name text field ----> */
                      CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .bankNameTransKey.toCurrentLanguage,
                          hintText: 'HBSJ Bank of New York',
                          prefixIcon: AppGaps.emptyGap),
                      AppGaps.hGap24,
                      /* <---- Branch code text field ----> */
                      CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .branchCodeTransKey.toCurrentLanguage,
                          hintText: '2379 3820 2922',
                          textInputType: TextInputType.number,
                          prefixIcon: AppGaps.emptyGap),
                      AppGaps.hGap24,
                      /* <---- Account number text field ----> */
                      CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .accountNumberTransKey.toCurrentLanguage,
                        hintText: '3849 **** 2738',
                        prefixIcon: AppGaps.emptyGap,
                        textInputType: TextInputType.number,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(AppAssetImages.hideSVGLogoLine,
                              height: 20, width: 20),
                        ),
                      ),
                      AppGaps.hGap24,
                      /* <---- Amount of transfer text field ----> */
                      CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .amountOfTransferTransKey.toCurrentLanguage,
                          hintText: '500',
                          textInputType: TextInputType.number,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Text(r'$',
                                style:
                                    TextStyle(color: AppColors.bodyTextColor)),
                          )),
                      AppGaps.hGap30,
                    ],
                  ),
                ),
              ),
              /* <-------- Bottom bar --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedButtonWidget(
                onTap: () {},
                child: Text(AppLanguageTranslation
                    .addMoneyNowTransKey.toCurrentLanguage),
              )),
            ));
  }
}
