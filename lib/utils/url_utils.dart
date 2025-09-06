import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openWikipediaUrl(BuildContext context, String? url) async {
  if (url == null || url.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No Wikipedia link available for this launch.')),
    );
    return false;
  }

  final uri = Uri.tryParse(url);
  if (uri == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Invalid URL.')));
    return false;
  }

  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Failed to open link.')));
  }
  return launched;
}
