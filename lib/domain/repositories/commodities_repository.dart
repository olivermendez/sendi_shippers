import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/domain/entities/models/commodities/vehicles_bodytypes_model.dart';

import '../entities/models/commodities/motor_bodytypes_model.dart';

/*
  Clase abstracta que implementa los metodos que queremos
  Pero no muestra el como se implementan estos métodos.
*/

abstract class CommoditiesRepository {
  Future<List<CommodityDetails>> getCommodities();
  Future<List<MotorBodytypeDetail>> getMotorBodyTypes();
  Future<List<VehicleBodytypeDetail>> getVehicleBodyTypes();
}
