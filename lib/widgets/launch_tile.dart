import 'package:flutter/material.dart';
import 'package:spacex_launches/models/launch.dart';
import 'package:spacex_launches/utils/date_utils.dart';

class LaunchTile extends StatelessWidget {
  final Launch launch;
  final VoidCallback onTap;

  const LaunchTile({required this.launch, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final dt = formatDateTime(launch.launchDateUtc);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: const Color(0xFF141414),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 104,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(dt['date'] ?? '—', style: const TextStyle(color: Color(0xFFBFFF33), fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(dt['time'] ?? '—', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(launch.missionName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(launch.launchSite?.siteNameLong ?? '', style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
