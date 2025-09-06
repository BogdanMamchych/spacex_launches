// models/rocket.dart
class Rocket {
  final int id;
  final bool active;
  final int stages;
  final int boosters;
  final int costPerLaunch;
  final int successRatePct;
  final String firstFlight; // ISO date
  final String country;
  final String company;
  final Dimension height;
  final Dimension diameter;
  final Mass mass;
  final List<PayloadWeight> payloadWeights;
  final FirstStageSpecs firstStage;
  final SecondStageSpecs secondStage;
  final Engines engines;
  final LandingLegs landingLegs;
  final List<String> flickrImages;
  final String? wikipedia;
  final String? description;
  final String rocketId;
  final String rocketName;
  final String rocketType;

  Rocket({
    required this.id,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.costPerLaunch,
    required this.successRatePct,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.height,
    required this.diameter,
    required this.mass,
    required this.payloadWeights,
    required this.firstStage,
    required this.secondStage,
    required this.engines,
    required this.landingLegs,
    required this.flickrImages,
    this.wikipedia,
    this.description,
    required this.rocketId,
    required this.rocketName,
    required this.rocketType,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'] as int,
      active: json['active'] as bool,
      stages: json['stages'] as int,
      boosters: json['boosters'] as int,
      costPerLaunch: json['cost_per_launch'] as int,
      successRatePct: json['success_rate_pct'] as int,
      firstFlight: json['first_flight'] as String,
      country: json['country'] as String,
      company: json['company'] as String,
      height: Dimension.fromJson(json['height'] as Map<String, dynamic>),
      diameter: Dimension.fromJson(json['diameter'] as Map<String, dynamic>),
      mass: Mass.fromJson(json['mass'] as Map<String, dynamic>),
      payloadWeights: (json['payload_weights'] as List<dynamic>).map((e) => PayloadWeight.fromJson(e as Map<String, dynamic>)).toList(),
      firstStage: FirstStageSpecs.fromJson(json['first_stage'] as Map<String, dynamic>),
      secondStage: SecondStageSpecs.fromJson(json['second_stage'] as Map<String, dynamic>),
      engines: Engines.fromJson(json['engines'] as Map<String, dynamic>),
      landingLegs: LandingLegs.fromJson(json['landing_legs'] as Map<String, dynamic>),
      flickrImages: (json['flickr_images'] as List<dynamic>).map((e) => e as String).toList(),
      wikipedia: json['wikipedia'] as String?,
      description: json['description'] as String?,
      rocketId: json['rocket_id'] as String,
      rocketName: json['rocket_name'] as String,
      rocketType: json['rocket_type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'active': active,
        'stages': stages,
        'boosters': boosters,
        'cost_per_launch': costPerLaunch,
        'success_rate_pct': successRatePct,
        'first_flight': firstFlight,
        'country': country,
        'company': company,
        'height': height.toJson(),
        'diameter': diameter.toJson(),
        'mass': mass.toJson(),
        'payload_weights': payloadWeights.map((p) => p.toJson()).toList(),
        'first_stage': firstStage.toJson(),
        'second_stage': secondStage.toJson(),
        'engines': engines.toJson(),
        'landing_legs': landingLegs.toJson(),
        'flickr_images': flickrImages,
        'wikipedia': wikipedia,
        'description': description,
        'rocket_id': rocketId,
        'rocket_name': rocketName,
        'rocket_type': rocketType,
      };
}

/* helper classes */

class Dimension {
  final num? meters;
  final num? feet;
  Dimension({this.meters, this.feet});
  factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(meters: json['meters'] as num?, feet: json['feet'] as num?);
  Map<String, dynamic> toJson() => {'meters': meters, 'feet': feet};
}

class Mass {
  final int? kg;
  final int? lb;
  Mass({this.kg, this.lb});
  factory Mass.fromJson(Map<String, dynamic> json) => Mass(kg: json['kg'] as int?, lb: json['lb'] as int?);
  Map<String, dynamic> toJson() => {'kg': kg, 'lb': lb};
}

class PayloadWeight {
  final String id;
  final String name;
  final int? kg;
  final int? lb;
  PayloadWeight({required this.id, required this.name, this.kg, this.lb});
  factory PayloadWeight.fromJson(Map<String, dynamic> json) => PayloadWeight(id: json['id'] as String, name: json['name'] as String, kg: json['kg'] as int?, lb: json['lb'] as int?);
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'kg': kg, 'lb': lb};
}

class FirstStageSpecs {
  final bool? reusable;
  final int? engines;
  final num? fuelAmountTons;
  final int? burnTimeSec;
  final Thrust? thrustSeaLevel;
  final Thrust? thrustVacuum;

  FirstStageSpecs({this.reusable, this.engines, this.fuelAmountTons, this.burnTimeSec, this.thrustSeaLevel, this.thrustVacuum});

  factory FirstStageSpecs.fromJson(Map<String, dynamic> json) => FirstStageSpecs(
        reusable: json['reusable'] as bool?,
        engines: json['engines'] as int?,
        fuelAmountTons: json['fuel_amount_tons'] as num?,
        burnTimeSec: json['burn_time_sec'] as int?,
        thrustSeaLevel: json['thrust_sea_level'] != null ? Thrust.fromJson(json['thrust_sea_level'] as Map<String, dynamic>) : null,
        thrustVacuum: json['thrust_vacuum'] != null ? Thrust.fromJson(json['thrust_vacuum'] as Map<String, dynamic>) : null,
      );

  Map<String, dynamic> toJson() => {
        'reusable': reusable,
        'engines': engines,
        'fuel_amount_tons': fuelAmountTons,
        'burn_time_sec': burnTimeSec,
        'thrust_sea_level': thrustSeaLevel?.toJson(),
        'thrust_vacuum': thrustVacuum?.toJson(),
      };
}

class SecondStageSpecs {
  final bool? reusable;
  final int? engines;
  final num? fuelAmountTons;
  final int? burnTimeSec;
  final Thrust? thrust;
  final Map<String, dynamic>? payloads;

  SecondStageSpecs({this.reusable, this.engines, this.fuelAmountTons, this.burnTimeSec, this.thrust, this.payloads});

  factory SecondStageSpecs.fromJson(Map<String, dynamic> json) => SecondStageSpecs(
        reusable: json['reusable'] as bool?,
        engines: json['engines'] as int?,
        fuelAmountTons: json['fuel_amount_tons'] as num?,
        burnTimeSec: json['burn_time_sec'] as int?,
        thrust: json['thrust'] != null ? Thrust.fromJson(json['thrust'] as Map<String, dynamic>) : null,
        payloads: json['payloads'] != null ? Map<String, dynamic>.from(json['payloads'] as Map) : null,
      );

  Map<String, dynamic> toJson() => {
        'reusable': reusable,
        'engines': engines,
        'fuel_amount_tons': fuelAmountTons,
        'burn_time_sec': burnTimeSec,
        'thrust': thrust?.toJson(),
        'payloads': payloads,
      };
}

class Thrust {
  final num? kN;
  final num? lbf;
  Thrust({this.kN, this.lbf});
  factory Thrust.fromJson(Map<String, dynamic> json) => Thrust(kN: json['kN'] as num?, lbf: json['lbf'] as num?);
  Map<String, dynamic> toJson() => {'kN': kN, 'lbf': lbf};
}

class Engines {
  final int? number;
  final String? type;
  final String? version;
  final String? layout;
  final Isp? isp;
  final int? engineLossMax;
  final String? propellant1;
  final String? propellant2;
  final Thrust? thrustSeaLevel;
  final Thrust? thrustVacuum;
  final num? thrustToWeight;

  Engines({
    this.number,
    this.type,
    this.version,
    this.layout,
    this.isp,
    this.engineLossMax,
    this.propellant1,
    this.propellant2,
    this.thrustSeaLevel,
    this.thrustVacuum,
    this.thrustToWeight,
  });

  factory Engines.fromJson(Map<String, dynamic> json) => Engines(
        number: json['number'] as int?,
        type: json['type'] as String?,
        version: json['version'] as String?,
        layout: json['layout'] as String?,
        isp: json['isp'] != null ? Isp.fromJson(json['isp'] as Map<String, dynamic>) : null,
        engineLossMax: json['engine_loss_max'] as int?,
        propellant1: json['propellant_1'] as String?,
        propellant2: json['propellant_2'] as String?,
        thrustSeaLevel: json['thrust_sea_level'] != null ? Thrust.fromJson(json['thrust_sea_level'] as Map<String, dynamic>) : null,
        thrustVacuum: json['thrust_vacuum'] != null ? Thrust.fromJson(json['thrust_vacuum'] as Map<String, dynamic>) : null,
        thrustToWeight: json['thrust_to_weight'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'type': type,
        'version': version,
        'layout': layout,
        'isp': isp?.toJson(),
        'engine_loss_max': engineLossMax,
        'propellant_1': propellant1,
        'propellant_2': propellant2,
        'thrust_sea_level': thrustSeaLevel?.toJson(),
        'thrust_vacuum': thrustVacuum?.toJson(),
        'thrust_to_weight': thrustToWeight,
      };
}

class Isp {
  final num? seaLevel;
  final num? vacuum;
  Isp({this.seaLevel, this.vacuum});
  factory Isp.fromJson(Map<String, dynamic> json) => Isp(seaLevel: json['sea_level'] as num?, vacuum: json['vacuum'] as num?);
  Map<String, dynamic> toJson() => {'sea_level': seaLevel, 'vacuum': vacuum};
}

class LandingLegs {
  final int? number;
  final String? material;
  LandingLegs({this.number, this.material});
  factory LandingLegs.fromJson(Map<String, dynamic> json) => LandingLegs(number: json['number'] as int?, material: json['material'] as String?);
  Map<String, dynamic> toJson() => {'number': number, 'material': material};
}
