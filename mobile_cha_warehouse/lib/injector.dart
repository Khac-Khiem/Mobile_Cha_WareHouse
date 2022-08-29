import 'package:get_it/get_it.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/container_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/inconsistency_container_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/issue_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/item_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/login_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/production_employee_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/receipt_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/slot_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/repositories_impl/stockcard_repository_impl.dart';
import 'package:mobile_cha_warehouse/datasource/service/container_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/inconsistency_container_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/issue_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/item_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/login_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/production_employee_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/slot_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/stockcard_service.dart';
import 'package:mobile_cha_warehouse/domain/repositories/container_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/inconsistency_container_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/item_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/login_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/production_employee_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/slot_repository.dart';
import 'package:mobile_cha_warehouse/domain/repositories/stockcard_repository.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/inconsistency_container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/login_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/production_employee_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/stockcard_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_per_basket_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/login_screen.dart';

final injector = GetIt.instance;
Future<void> initializeDependencies() async {
  //register http
  injector.registerSingleton<ReceiptService>(ReceiptService());
  injector.registerSingleton<IssueService>(IssueService());
  injector.registerSingleton<StockCardService>(StockCardService());
  injector.registerSingleton<ContainerService>(ContainerService());
  injector.registerSingleton<ItemService>(ItemService());
  injector.registerSingleton<LoginService>(LoginService());
  injector.registerSingleton<SlotService>(SlotService());
   injector.registerSingleton<ProductionService>(ProductionService());
  injector.registerSingleton<InconsistencyContainerService>(
      InconsistencyContainerService());
  //register repo
  injector.registerSingleton<ContainRepo>(ContainerRepoImpl(injector()));
  injector.registerSingleton<ReceiptsRepo>(ReceiptRepositoryImpl(injector()));
  injector.registerSingleton<IssuesRepo>(IssueRepoImpl(injector()));
  injector.registerSingleton<InconsistencyContainerRepository>(
      InconsistencyContainerRepoImpl(injector()));
  injector.registerSingleton<ItemRepository>(ItemRepositoryimpl(injector()));
  injector.registerSingleton<SlotRepository>(SlotRepositoryImpl(injector()));
    injector.registerSingleton<ProductionEmployeeRepository>(ProductionEmployeeRepoImpl(injector()));
  injector
      .registerSingleton<StockCardRepo>(StockCardRepositoryImpl(injector()));
  injector.registerSingleton<LoginRepository>(LoginRepoImpl(injector()));
  //register usecase
  injector.registerSingleton<ContainerUseCase>(ContainerUseCase(injector()));
  injector.registerSingleton<ReceiptUseCase>(ReceiptUseCase(injector()));
  injector.registerSingleton<IssueUseCase>(IssueUseCase(injector()));
    injector.registerSingleton<ProductionEmployeeUseCase>(ProductionEmployeeUseCase(injector()));

  injector.registerSingleton<InconsistencyContainerUseCase>(
      InconsistencyContainerUseCase(injector()));
  injector.registerSingleton<ItemUseCase>(ItemUseCase(injector()));
  injector.registerSingleton<SlotUseCase>(SlotUseCase(injector()));
  injector.registerSingleton<StockCardsUseCase>(StockCardsUseCase(injector()));
  injector.registerSingleton<LoginUsecase>(LoginUsecase(injector()));
  //register bloc
  
  injector.registerFactory<LoginBloc>(() => LoginBloc());

  // injector.registerFactory<IssueBloc>(() => IssueBloc(injector()));
  injector.registerSingleton<IssueBloc>(IssueBloc(injector(), injector(),injector()));

  //injector.registerFactory<ReceiptBloc>(() => ReceiptBloc(injector()));
  injector.registerSingleton<ReceiptBloc>(ReceiptBloc(injector(), injector(), injector(), injector()));

  injector.registerSingleton<CheckInfoBloc>(CheckInfoBloc(injector(), injector()));
 // injector.registerFactory<CheckInfoBloc>(() => CheckInfoBloc(injector()));

  injector.registerSingleton<StockCardViewBloc>(
      StockCardViewBloc(injector(), injector()));
  // injector.registerFactory<StockCardViewBloc>(
  //     () => StockCardViewBloc(injector(), injector()));
   injector.registerSingleton<EditPerBasketBloc>(
      EditPerBasketBloc(injector(), injector()));
}
