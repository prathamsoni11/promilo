import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promilo/cubits/app_bar_title_cubit.dart';
import 'package:promilo/screens/description_screen.dart';
import 'package:promilo/utils/colors.dart';
import 'package:promilo/utils/screen_names.dart';
import 'package:promilo/utils/sized_boxes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MeetUpScreen extends StatefulWidget {
  const MeetUpScreen({super.key});
  @override
  State<MeetUpScreen> createState() => _MeetUpScreenState();
}

class _MeetUpScreenState extends State<MeetUpScreen> {
  final ValueNotifier _carouselCurrentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _carouselCurrentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "Search",
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 22,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.mic,
                  size: 22,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          _buildCarouselSliderWithIndicator(size, theme),
          _buildTrendingPeople(size, theme),
          _buildTopTrendingMeetups(size, theme),
          AppSizedBoxes.height30,
        ],
      ),
    );
  }

  Widget _buildCarouselSliderWithIndicator(Size size, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                margin: const EdgeInsets.all(1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/meeting${itemIndex + 1}.jpeg",
                        fit: BoxFit.cover,
                        width: size.width,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: SizedBox(
                          width: size.width / 3,
                          child: Text(
                            "Popular Meetups in India",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                _carouselCurrentIndex.value = index;
              },
            ),
          ),
          AppSizedBoxes.height10,
          ValueListenableBuilder(
            valueListenable: _carouselCurrentIndex,
            builder: (BuildContext context, value, Widget? child) {
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
        ],
      ),
    );
  }

  Widget _buildTrendingPeople(Size size, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 20, top: 30),
          child: Text(
            "Trending Popular People",
            style:
                theme.textTheme.titleLarge?.copyWith(color: AppColors.text100),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemExtent: size.width * 0.8,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 44,
                          width: 44,
                          child: const Icon(
                            Icons.energy_savings_leaf_outlined,
                            size: 20,
                          ),
                        ),
                        AppSizedBoxes.width10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Author",
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            AppSizedBoxes.height5,
                            Text(
                              "1,028 Meetups",
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.normal,
                                color: AppColors.text200,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: 60,
                      width: size.width,
                      child: Stack(
                        children: List.generate(
                          5,
                          (index) => Positioned(
                            left: 28 * 2 * index * 0.75,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(
                                  "assets/images/meeting${index + 1}.jpeg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppSizedBoxes.height10,
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          elevation: 0,
                        ),
                        child: const Text("See more"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopTrendingMeetups(Size size, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 20, top: 30),
          child: Text(
            "Top Trending Meetups",
            style:
                theme.textTheme.titleLarge?.copyWith(color: AppColors.text100),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DescriptionScreen(),
                    ),
                  );
                  context
                      .read<AppBarTitleCubit>()
                      .setTitle(AppScreenNames.descriptionScreen);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 14),
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/meeting${index + 1}.jpeg",
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "0${index + 1}",
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: AppColors.text100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
