import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/terms/terms_view_model.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:flutter/material.dart';

class TermsView extends LinearView<TermsViewModel> {
  const TermsView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, TermsViewModel viewModel) {
    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.settings,
        content: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  LocaleContext.get().terms_terms_and_conditions,
                  style: AppText.header,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.widgetSecondary.withOpacity(0.3),
                      ),
                    ),
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        _termsText,
                        style: AppText.subHeader,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: viewModel.accepted,
                      activeColor: AppColor.widgetSecondary,
                      onChanged: viewModel.toggleAccepted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        LocaleContext.get().terms_i_have_read_and_accept,
                        style: AppText.smallHeader,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormattedButton(
                      content: LocaleContext.get().terms_continue,
                      textColor: Colors.white,
                      disabled: !viewModel.accepted,
                      onPress: () async => viewModel.acceptTerms(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _termsText = '''
EcoProve Terms and Conditions of Use

Version 1.0 - June 2026

Preamble

EcoProve is a gamified digital platform designed to promote the active participation of consumers in Circular Economy (CE) practices within the textile and apparel sector through intelligent wardrobe management. The platform operates within the broader context of the transition towards sustainable production and consumption models and supports the principles underlying the Digital Product Passport (DPP), which aims to improve traceability, transparency, and circularity throughout the lifecycle of textile products.

Furthermore, EcoProve has been developed and is operated as part of an academic research project. The platform seeks to contribute to scientific knowledge regarding consumer behaviour, sustainable consumption, garment lifecycle management, and Circular Economy practices. The information gathered through the Platform can be used for research, education, and statistics, following the relevant data protection laws and the rules in these Terms and Conditions.

These Terms and Conditions govern access to and use of the EcoProve Platform and define the rights and obligations of both EcoProve and its users. By creating an account and accessing the Platform, the user acknowledges that they have read, understood, and accepted these Terms in full.

1. Definitions

For the purposes of these Terms and Conditions:

"EcoProve" means the gamified digital application designed to support sustainable wardrobe management and encourage participation in Circular Economy practices.

"User" means any natural person who creates an account and accesses the platform.

"Garment" or "Item" means any clothing article registered by the user on the platform.

"Circular Action" means any activity recorded on the platform relating to prolonged use, maintenance, repair, sharing, donation, resale, remanufacturing, upcycling, or recycling of garments.

"EcoProve Points" means the gamification units awarded for registered Circular Actions. EcoProve Points have no monetary value.

"Digital Product Passport (DPP)" means a structured record containing information about the lifecycle of a textile product for traceability, sustainability, and circularity purposes.

"Usage Data" means information recorded by users regarding the use, maintenance, repair, and end-of-life management of their garments.

"User Content" means any information, images, descriptions, or other content uploaded or submitted by users through the platform.

2. Access and Registration

2.1 Eligibility

Access to EcoProve is available to individuals aged 16 years or older. Users under the age of 18 must obtain consent from a parent or legal guardian before using the platform.

2.2 Account Creation

Registration requires the provision of basic personal information, including a name, email address, and password.

Users are responsible for ensuring that all information provided is accurate, complete, and up to date and for maintaining the confidentiality of their login credentials.

2.3 Personal and Non-Transferrable Use

User accounts are personal and may not be transferred, sold, shared, or assigned to third parties.

EcoProve reserves the right to suspend or terminate accounts suspected of misuse, fraudulent activity, or unauthorised access.

3. Platform Features

3.1 Wardrobe Management

Users may register garments and associated information, including brand, composition, acquisition date, and condition. This functionality aims to improve wardrobe organisation and awareness of clothing consumption patterns.

3.2 Usage Tracking

The platform enables users to record the number of times a garment is worn, supporting the monitoring of consumption patterns and encouraging the extended use of existing products.

3.3 Maintenance and Repair Activities

Users may document washing, maintenance, care, and repair activities carried out on garments, contributing to longer product lifecycles and generating data relevant to the Digital Product Passport.

3.4 Sustainable End-of-Life Actions

The platform allows users to record activities related to garment end-of-life management, including donation, sharing, resale, remanufacturing, upcycling, and recycling.

3.5 Gamification System

Users may earn EcoProve Points, badges, achievements, and mission rewards by recording Circular Actions.

EcoProve Points and rewards have no monetary value and cannot be exchanged for cash, goods, services, or other benefits unless expressly stated by EcoProve.

3.6 Digital Product Passport Data

Usage Data may be used, in anonymised and aggregated form, to support the development and validation of Digital Product Passport models and related sustainability initiatives.

4. User Obligations

By using the platform, users agree to the following:

- Provide accurate, complete, and up-to-date information;
- Use the Platform only for its intended purposes and in compliance with applicable laws;
- Refrain from uploading false, misleading, defamatory, offensive, discriminatory, or unlawful content;
- Refrain from manipulating or attempting to exploit the Platform's gamification mechanisms;
- Refrain from reverse engineering, decompiling, or attempting to extract the platform's source code;
- Refrain from using automated systems, bots, scrapers, or similar technologies without prior authorisation;
- Notify EcoProve immediately of any unauthorised use of your account or any security breach.

5. Data Protection and Privacy

5.1 Data Collected

EcoProve may collect and process:
- Registration information, including name and email address;
- Platform usage data;
- Garment registration data;
- Records of Circular Actions;
- User-generated content;
- Technical information such as IP addresses, device information, browser type, operating system, and session preferences.

5.2 Purposes of Processing

EcoProve is developed and operated as part of an academic research project.

Personal data and Platform usage information may be processed for the following purposes:
- Providing access to the Platform and managing user accounts;
- Delivering, maintaining, and improving Platform services;
- Monitoring user engagement with sustainability and Circular Economy practices;
- Conducting academic, educational, scientific, and statistical research;
- Analysing consumer behaviour and garment lifecycle management practices;
- Supporting the development, validation, and evaluation of Digital Product Passport frameworks and sustainability models;
- Producing anonymised reports, academic publications, conference papers, dissertations, theses, and other research outputs;
- Communicating with Users regarding service updates, notifications, and security matters;
- Ensuring compliance with legal obligations.

5.3 Research and Educational Purposes

The Platform is operated primarily for academic and scientific research purposes.

Information collected through EcoProve may be used to analyse consumer behaviour, sustainability practices, garment usage patterns, repair and maintenance activities, and Circular Economy engagement within the textile and apparel sector.

Any analyses, reports, academic publications, presentations, dissertations, theses, or other research outputs derived from the collected data shall be produced solely in anonymised and aggregated form.

No personally identifiable information will be disclosed in any academic publication, presentation, report, or public dissemination activity.

Where appropriate, anonymised and aggregated datasets may be shared with universities, research institutions, supervisors, scientific journals, funding bodies, and project partners involved in the research, provided that such sharing complies with all applicable legal, ethical, and regulatory requirements.

By creating an account and using the platform, users acknowledge and agree that their information may be processed for the academic research purposes described in these Terms and Conditions.

5.4 User Rights

Users have the right to:
- Access their personal data;
- Rectify inaccurate or incomplete information;
- Request erasure of personal data;
- Restrict or object to processing;
- Request data portability;
- Withdraw consent where processing is based on consent.

Requests relating to data protection rights may be submitted using the contact details provided in the Privacy Policy.

6. Intellectual Property

6.1 EcoProve Intellectual Property

All intellectual property rights relating to the Platform, including software, architecture, design, graphics, logos, content, gamification systems, databases, algorithms, and documentation, belong exclusively to EcoProve or its licensors.

6.2 User Content

Users retain ownership of the content they upload to the platform.

By submitting content, users grant EcoProve a non-exclusive, worldwide, royalty-free licence to use, process, reproduce, and store such content solely for the purposes of operating, improving, and researching the Platform.

6.3 Restrictions

No element of the Platform may be copied, reproduced, distributed, modified, published, or otherwise exploited without prior written permission from EcoProve.

7. Limitation of Liability

7.1 Service Availability

EcoProve will make reasonable efforts to ensure Platform availability but does not guarantee uninterrupted or error-free operation.

7.2 Informational Nature

The Platform is intended to support sustainable consumption practices and does not constitute professional legal, environmental, technical, or financial advice.

7.3 User Content

EcoProve is not responsible for content submitted by Users and accepts no liability for inaccuracies, omissions, or unlawful content uploaded by Users.

7.4 Indirect Damages

To the fullest extent permitted by law, EcoProve shall not be liable for indirect, incidental, consequential, or special damages arising from the use of, or inability to use, the Platform.

8. Suspension and Termination

8.1 Termination by the User

Users may delete their account at any time.

Upon account deletion, personal data will be removed unless retention is required by law or justified by legitimate research or legal obligations.

8.2 Termination by EcoProve

EcoProve may suspend or terminate accounts that violate these Terms, engage in fraudulent activity, compromise Platform security, or otherwise interfere with the operation of the platform.

9. Amendments

EcoProve reserves the right to amend these Terms and Conditions at any time.

Users will be notified of material changes at least thirty (30) days before such changes take effect.

Continued use of the Platform following the effective date of any amendments constitutes acceptance of the revised Terms.

10. Governing Law and Dispute Resolution

These Terms and Conditions shall be governed by and interpreted in accordance with the laws of Portugal.

The parties shall endeavour to resolve disputes amicably.

Where applicable, consumers may access Alternative Dispute Resolution (ADR) mechanisms available under Portuguese law.

Any dispute that cannot be resolved amicably shall be submitted to the competent courts of Portugal, without prejudice to any mandatory consumer protection rights. ''';
}
