import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/issue_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

class IssueRepoImpl implements IssuesRepo {
  IssueService issueService;
  IssueRepoImpl(this.issueService);
  @override
  Future<List<GoodsIssueModel>> getGoodsIssues() {
    // TODO: implement getIssues
    final issues = issueService.getGoodsIssue();
    return issues;
  }

  @override
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId) {
    // TODO: implement getGoodsIssueById
    final issue = issueService.getGoodsIssueById(goodsIssueId);
    return issue;
  }

  @override
  Future<ErrorPackage> addContainerIssue(
      String issueId, List<Lots> lots) {
    // TODO: implement patchConfirmBasket
    final confirm = issueService.addContainerIssue(issueId, lots);
    return confirm;
  }

  @override
  Future getLotByItemId(String itemId) {
    // TODO: implement getLotByItemId\
    final lots = issueService.getLotByItemId(itemId);
    return lots;
  }

  // @override
  // Future<int> confirmGoodsIssue(String issueid) {
  //   // TODO: implement confirmGoodsIssue
  //   final status = issueService.confirmIssue(issueid);
  //   return status;
  // }
}
