// models/launch.dart
class Launch {
  final int flightNumber;
  final String missionName;
  final List<String> missionId;
  final bool upcoming;
  final String launchYear;
  final int launchDateUnix;
  final String launchDateUtc;
  final String? launchDateLocal;
  final bool launchSuccess;
  final RocketSummary? rocket;
  final LaunchSite? launchSite;
  final LaunchFailureDetails? launchFailureDetails;
  final Links links;
  final String? details;
  final Map<String, dynamic>? timeline;
  final DateTime? staticFireDateUtc;

  Launch({
    required this.flightNumber,
    required this.missionName,
    required this.missionId,
    required this.upcoming,
    required this.launchYear,
    required this.launchDateUnix,
    required this.launchDateUtc,
    this.launchDateLocal,
    required this.launchSuccess,
    this.rocket,
    this.launchSite,
    this.launchFailureDetails,
    required this.links,
    this.details,
    this.timeline,
    this.staticFireDateUtc,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      flightNumber: json['flight_number'] as int,
      missionName: json['mission_name'] as String,
      missionId: (json['mission_id'] as List<dynamic>).map((e) => e as String).toList(),
      upcoming: json['upcoming'] as bool,
      launchYear: json['launch_year'] as String,
      launchDateUnix: json['launch_date_unix'] as int,
      launchDateUtc: json['launch_date_utc'] as String,
      launchDateLocal: json['launch_date_local'] as String?,
      launchSuccess: json['launch_success'] as bool? ?? false,
      rocket: json['rocket'] != null ? RocketSummary.fromJson(json['rocket'] as Map<String, dynamic>) : null,
      launchSite: json['launch_site'] != null ? LaunchSite.fromJson(json['launch_site'] as Map<String, dynamic>) : null,
      launchFailureDetails: json['launch_failure_details'] != null
          ? LaunchFailureDetails.fromJson(json['launch_failure_details'] as Map<String, dynamic>)
          : null,
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      details: json['details'] as String?,
      timeline: json['timeline'] != null ? Map<String, dynamic>.from(json['timeline'] as Map) : null,
      staticFireDateUtc: json['static_fire_date_utc'] != null ? DateTime.tryParse(json['static_fire_date_utc'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'flight_number': flightNumber,
        'mission_name': missionName,
        'mission_id': missionId,
        'upcoming': upcoming,
        'launch_year': launchYear,
        'launch_date_unix': launchDateUnix,
        'launch_date_utc': launchDateUtc,
        'launch_date_local': launchDateLocal,
        'launch_success': launchSuccess,
        'rocket': rocket?.toJson(),
        'launch_site': launchSite?.toJson(),
        'launch_failure_details': launchFailureDetails?.toJson(),
        'links': links.toJson(),
        'details': details,
        'timeline': timeline,
        'static_fire_date_utc': staticFireDateUtc?.toIso8601String(),
      };
}

/* Nested helper classes */

class RocketSummary {
  final String rocketId;
  final String rocketName;
  final String rocketType;
  final FirstStage firstStage;
  final SecondStage secondStage;
  final Fairings? fairings;

  RocketSummary({
    required this.rocketId,
    required this.rocketName,
    required this.rocketType,
    required this.firstStage,
    required this.secondStage,
    this.fairings,
  });

  factory RocketSummary.fromJson(Map<String, dynamic> json) {
    return RocketSummary(
      rocketId: json['rocket_id'] as String,
      rocketName: json['rocket_name'] as String,
      rocketType: json['rocket_type'] as String,
      firstStage: FirstStage.fromJson(json['first_stage'] as Map<String, dynamic>),
      secondStage: SecondStage.fromJson(json['second_stage'] as Map<String, dynamic>),
      fairings: json['fairings'] != null ? Fairings.fromJson(json['fairings'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'rocket_id': rocketId,
        'rocket_name': rocketName,
        'rocket_type': rocketType,
        'first_stage': firstStage.toJson(),
        'second_stage': secondStage.toJson(),
        'fairings': fairings?.toJson(),
      };
}

class FirstStage {
  final List<Core> cores;
  FirstStage({required this.cores});
  factory FirstStage.fromJson(Map<String, dynamic> json) {
    final list = (json['cores'] as List<dynamic>).map((e) => Core.fromJson(e as Map<String, dynamic>)).toList();
    return FirstStage(cores: list);
  }
  Map<String, dynamic> toJson() => {'cores': cores.map((c) => c.toJson()).toList()};
}

class Core {
  final String? coreSerial;
  final int? flight;
  final int? block;
  final bool? gridfins;
  final bool? legs;
  final bool? reused;
  final bool? landSuccess;
  final bool? landingIntent;
  final String? landingType;
  final String? landingVehicle;

  Core({
    this.coreSerial,
    this.flight,
    this.block,
    this.gridfins,
    this.legs,
    this.reused,
    this.landSuccess,
    this.landingIntent,
    this.landingType,
    this.landingVehicle,
  });

  factory Core.fromJson(Map<String, dynamic> json) => Core(
        coreSerial: json['core_serial'] as String?,
        flight: json['flight'] as int?,
        block: json['block'] as int?,
        gridfins: json['gridfins'] as bool?,
        legs: json['legs'] as bool?,
        reused: json['reused'] as bool?,
        landSuccess: json['land_success'] as bool?,
        landingIntent: json['landing_intent'] as bool?,
        landingType: json['landing_type'] as String?,
        landingVehicle: json['landing_vehicle'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'core_serial': coreSerial,
        'flight': flight,
        'block': block,
        'gridfins': gridfins,
        'legs': legs,
        'reused': reused,
        'land_success': landSuccess,
        'landing_intent': landingIntent,
        'landing_type': landingType,
        'landing_vehicle': landingVehicle,
      };
}

class SecondStage {
  final int? block;
  final List<Payload> payloads;

  SecondStage({this.block, required this.payloads});

  factory SecondStage.fromJson(Map<String, dynamic> json) {
    return SecondStage(
      block: json['block'] as int?,
      payloads: (json['payloads'] as List<dynamic>).map((e) => Payload.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {'block': block, 'payloads': payloads.map((p) => p.toJson()).toList()};
}

class Payload {
  final String payloadId;
  final List<int> noradId;
  final bool reused;
  final List<String> customers;
  final String? nationality;
  final String? manufacturer;
  final String? payloadType;
  final num? payloadMassKg;
  final num? payloadMassLbs;
  final String? orbit;
  final OrbitParams? orbitParams;

  Payload({
    required this.payloadId,
    required this.noradId,
    required this.reused,
    required this.customers,
    this.nationality,
    this.manufacturer,
    this.payloadType,
    this.payloadMassKg,
    this.payloadMassLbs,
    this.orbit,
    this.orbitParams,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      payloadId: json['payload_id'] as String,
      noradId: (json['norad_id'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      reused: json['reused'] as bool,
      customers: (json['customers'] as List<dynamic>).map((e) => e as String).toList(),
      nationality: json['nationality'] as String?,
      manufacturer: json['manufacturer'] as String?,
      payloadType: json['payload_type'] as String?,
      payloadMassKg: json['payload_mass_kg'] as num?,
      payloadMassLbs: json['payload_mass_lbs'] as num?,
      orbit: json['orbit'] as String?,
      orbitParams: json['orbit_params'] != null ? OrbitParams.fromJson(json['orbit_params'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'payload_id': payloadId,
        'norad_id': noradId,
        'reused': reused,
        'customers': customers,
        'nationality': nationality,
        'manufacturer': manufacturer,
        'payload_type': payloadType,
        'payload_mass_kg': payloadMassKg,
        'payload_mass_lbs': payloadMassLbs,
        'orbit': orbit,
        'orbit_params': orbitParams?.toJson(),
      };
}

class OrbitParams {
  final String? referenceSystem;
  final String? regime;
  final num? periapsisKm;
  final num? apoapsisKm;
  final num? inclinationDeg;

  OrbitParams({
    this.referenceSystem,
    this.regime,
    this.periapsisKm,
    this.apoapsisKm,
    this.inclinationDeg,
  });

  factory OrbitParams.fromJson(Map<String, dynamic> json) => OrbitParams(
        referenceSystem: json['reference_system'] as String?,
        regime: json['regime'] as String?,
        periapsisKm: json['periapsis_km'] as num?,
        apoapsisKm: json['apoapsis_km'] as num?,
        inclinationDeg: json['inclination_deg'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'reference_system': referenceSystem,
        'regime': regime,
        'periapsis_km': periapsisKm,
        'apoapsis_km': apoapsisKm,
        'inclination_deg': inclinationDeg,
      };
}

class Fairings {
  final bool? reused;
  final bool? recoveryAttempt;
  final bool? recovered;
  final String? ship;

  Fairings({this.reused, this.recoveryAttempt, this.recovered, this.ship});

  factory Fairings.fromJson(Map<String, dynamic> json) => Fairings(
        reused: json['reused'] as bool?,
        recoveryAttempt: json['recovery_attempt'] as bool?,
        recovered: json['recovered'] as bool?,
        ship: json['ship'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'reused': reused,
        'recovery_attempt': recoveryAttempt,
        'recovered': recovered,
        'ship': ship,
      };
}

class LaunchSite {
  final String siteId;
  final String siteName;
  final String siteNameLong;

  LaunchSite({required this.siteId, required this.siteName, required this.siteNameLong});

  factory LaunchSite.fromJson(Map<String, dynamic> json) => LaunchSite(
        siteId: json['site_id'] as String,
        siteName: json['site_name'] as String,
        siteNameLong: json['site_name_long'] as String,
      );

  Map<String, dynamic> toJson() => {
        'site_id': siteId,
        'site_name': siteName,
        'site_name_long': siteNameLong,
      };
}

class LaunchFailureDetails {
  final int? time;
  final num? altitude;
  final String? reason;

  LaunchFailureDetails({this.time, this.altitude, this.reason});

  factory LaunchFailureDetails.fromJson(Map<String, dynamic> json) => LaunchFailureDetails(
        time: json['time'] as int?,
        altitude: json['altitude'] as num?,
        reason: json['reason'] as String?,
      );

  Map<String, dynamic> toJson() => {'time': time, 'altitude': altitude, 'reason': reason};
}

class Links {
  final String? missionPatch;
  final String? missionPatchSmall;
  final String? articleLink;
  final String? wikipedia;
  final String? videoLink;
  final String? youtubeId;
  final List<String> flickrImages;

  Links({
    this.missionPatch,
    this.missionPatchSmall,
    this.articleLink,
    this.wikipedia,
    this.videoLink,
    this.youtubeId,
    required this.flickrImages,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        missionPatch: json['mission_patch'] as String?,
        missionPatchSmall: json['mission_patch_small'] as String?,
        articleLink: json['article_link'] as String?,
        wikipedia: json['wikipedia'] as String?,
        videoLink: json['video_link'] as String?,
        youtubeId: json['youtube_id'] as String?,
        flickrImages: (json['flickr_images'] as List<dynamic>).map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() => {
        'mission_patch': missionPatch,
        'mission_patch_small': missionPatchSmall,
        'article_link': articleLink,
        'wikipedia': wikipedia,
        'video_link': videoLink,
        'youtube_id': youtubeId,
        'flickr_images': flickrImages,
      };
}
