import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComplaintInformationWidget extends StatelessWidget {
  const ComplaintInformationWidget({
    super.key,
    required this.titleColor,
    required this.hintColor,
    required this.image,
    required this.title,
    required this.hint,
  });
  final Color titleColor;
  final String title;
  final String hint;
  final Color hintColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        children: [
          SvgPicture.asset(image),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,

              fontFamily: AppFonts.tasees,
              fontSize: SizeConfig.diagonal * (isEn ? .017 : .018),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              hint,
              textAlign: TextAlign.center, // ✅
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hintColor,
                fontFamily: AppFonts.tasees,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
