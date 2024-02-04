import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:promilo/cubits/app_bar_title_cubit.dart';
import 'package:promilo/utils/colors.dart';
import 'package:promilo/utils/screen_names.dart';
import 'package:promilo/utils/sized_boxes.dart';
import 'package:promilo/widgets/icon_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final ValueNotifier<int> _carouselCurrentIndex = ValueNotifier(0);
  final ValueNotifier<bool> _seeMoreButtonVisible = ValueNotifier(true);

  @override
  void dispose() {
    _carouselCurrentIndex.dispose();
    _seeMoreButtonVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PopScope(
      onPopInvoked: (_) {
        context.read<AppBarTitleCubit>().setTitle(AppScreenNames.meetupScreen);
      },
      child: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBoxes.height20,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CarouselSlider.builder(
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Image.asset(
                                  "assets/images/meeting${itemIndex + 1}.jpeg",
                                  fit: BoxFit.cover,
                                );
                              },
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                height: 350,
                                onPageChanged: (index, _) {
                                  _carouselCurrentIndex.value = index;
                                },
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ValueListenableBuilder(
                                valueListenable: _carouselCurrentIndex,
                                builder: (BuildContext context, int value,
                                    Widget? child) {
                                  return AnimatedSmoothIndicator(
                                    activeIndex: value,
                                    count: 3,
                                    effect: const WormEffect(
                                      spacing: 8,
                                      dotHeight: 8,
                                      dotWidth: 8,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(CupertinoIcons.tray_arrow_down),
                            const Icon(CupertinoIcons.bookmark),
                            const Icon(CupertinoIcons.heart),
                            const Icon(CupertinoIcons.crop),
                            const Icon(CupertinoIcons.star),
                            AppIconButton(
                              onPressed: () {
                                Share.share(
                                  "This is share",
                                  subject: 'Look what I made!',
                                );
                              },
                              icon: const Icon(Icons.share),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                AppSizedBoxes.height10,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    buildIconWithCount(
                      iconData: CupertinoIcons.bookmark,
                      count: "1034",
                      onPressed: () {},
                    ),
                    buildIconWithCount(
                      iconData: CupertinoIcons.heart,
                      count: "1034",
                      onPressed: () {},
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: RatingBar.builder(
                        initialRating: 3.2,
                        unratedColor: Colors.white,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemSize: 12,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => const Icon(
                          CupertinoIcons.star_fill,
                          color: AppColors.enabledButton,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    const Text(
                      "3.2",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                AppSizedBoxes.height20,
                Text(
                  "Actor Name",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.text100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSizedBoxes.height5,
                Text(
                  "Indian Actress",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.text200,
                  ),
                ),
                AppSizedBoxes.height10,
                Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.clock,
                      size: 16,
                      color: AppColors.text200,
                    ),
                    Text(
                      "Duration 20 Mins",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.text200,
                      ),
                    )
                  ],
                ),
                AppSizedBoxes.height10,
                Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.wallet,
                      size: 16,
                      color: AppColors.text200,
                    ),
                    Text(
                      "Total Average Fees ₹9,999",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.text200,
                      ),
                    ),
                  ],
                ),
                AppSizedBoxes.height10,
                Text(
                  "About",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.text100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSizedBoxes.height10,
                ValueListenableBuilder(
                  valueListenable: _seeMoreButtonVisible,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Column(
                      children: [
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          maxLines: value ? 5 : null,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.text200,
                          ),
                        ),
                        Visibility(
                          visible: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                _seeMoreButtonVisible.value = false;
                              },
                              child: const Text("See More"),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AppSizedBoxes.height30,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIconWithCount({
    required IconData iconData,
    required String count,
    required VoidCallback onPressed,
  }) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppIconButton(
          onPressed: onPressed,
          icon: Icon(
            iconData,
            size: 16,
            color: AppColors.enabledButton,
          ),
        ),
        Text(
          count,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
