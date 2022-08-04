import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/domain/entities/models/commodities/motor_bodytypes_model.dart';
import 'package:my_app/domain/entities/models/commodities/vehicles_bodytypes_model.dart';
import 'package:my_app/domain/repositories/commodities_repository.dart';

class CommoditiesUsesCases {
  final CommoditiesRepository _commoditiesRepository;
  CommoditiesUsesCases(this._commoditiesRepository);

  Future<List<CommodityDetails>> getAllCommodities() {
    return _commoditiesRepository.getCommodities();
  }

  Future<List<MotorBodytypeDetail>> getAllMotorBodyTypes() {
    return _commoditiesRepository.getMotorBodyTypes();
  }

  Future<List<VehicleBodytypeDetail>> getAllVehiclesBodyTypes() {
    return _commoditiesRepository.getVehicleBodyTypes();
  }
}
