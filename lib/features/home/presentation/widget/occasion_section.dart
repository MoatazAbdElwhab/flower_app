// features/home/presentation/widget/occasion_section.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/presentation/widget/item_card.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flower_app/features/occasion/presentation/pages/occasion_page.dart';
import 'package:flutter/material.dart';

class OccasionSection extends StatelessWidget {
  final List<CategoryOccasionEntity> occasions;

  const OccasionSection({
    super.key,
    required this.occasions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerSpacing = size.height * 0.01;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //////////////////////////////////////////////////Occasion section header
        SectionHeader(
          title: 'home.sections.occasion'.tr(),
          onViewAllTap: () {},
        ),
        SizedBox(height: headerSpacing),

        //////////////////////////////////////////////////occasion list view
        Expanded(
          child: occasions.isEmpty
              ? Center(child: Text('home.empty_states.occasions'.tr()))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: occasions.length,
                  itemBuilder: (context, index) {
                    final occasion = occasions[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.occasion,
                          arguments: OccasionPageArguments(
                            categories: occasions,
                            selectedCategoryIndex: index,
                          ),
                        );
                      },
                      child: ItemCard(
                        id: occasion.id,
                        title: occasion.name,
                        imageUrl: occasion.image,
                        showPrice: false,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
