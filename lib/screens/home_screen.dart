import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_launches/providers/spacex_provider.dart';
import 'package:spacex_launches/widgets/rocket_slider.dart';
import 'package:spacex_launches/widgets/launch_tile.dart';
import 'package:spacex_launches/utils/url_utils.dart';

class SpaceXLaunchesHomePage extends ConsumerWidget {
  const SpaceXLaunchesHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketsAsyncList = ref.watch(rocketsListProvider);
    final launchesAsyncList = ref.watch(launchesListProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    const cardRadius = 14.0;
    const double stroke = 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('SpaceX Launches', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: rocketsAsyncList.when(
            data: (rockets) {
              if (rockets.isEmpty) return const Center(child: Text('No rockets found', style: TextStyle(color: Colors.white70)));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RocketSlider(
                    rockets: rockets,
                    onPageChanged: (index) => ref.read(currentIndexProvider.notifier).state = index,
                    currentIndex: currentIndex,
                    cardRadius: cardRadius,
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: DotsIndicator(
                      dotsCount: rockets.length,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.transparent,
                        shape: CircleBorder(side: BorderSide(color: Colors.white, width: stroke)),
                        activeColor: Colors.white,
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        spacing: const EdgeInsets.symmetric(horizontal: 1.5),
                      ),
                    )
                  ),

                  const SizedBox(height: 18),

                  const Padding(
                    padding: EdgeInsets.only(left: 4.0, bottom: 8),
                    child: Text('Missions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),

                  Expanded(
                    child: launchesAsyncList.when(
                      data: (allLaunches) {
                        final launches = allLaunches
                            .where((launch) => launch.rocket?.rocketId == rockets[currentIndex].rocketId)
                            .toList();

                        if (launches.isEmpty) {
                          return const Center(child: Text('No launches for this rocket', style: TextStyle(color: Colors.white70)));
                        }

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: launches.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 3),
                          itemBuilder: (context, index) {
                            final launch = launches[index];
                            return LaunchTile(
                              launch: launch,
                              onTap: () => openWikipediaUrl(context, launch.links.wikipedia),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, st) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
          ),
        ),
      ),
    );
  }
}
