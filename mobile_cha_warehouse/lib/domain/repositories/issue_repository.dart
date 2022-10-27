import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

abstract class IssuesRepo {
  Future<List<GoodsIssue>> getGoodsIssues();
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future<ErrorPackage> addContainerIssue(
      String issueId, List<Lots> lots);
  Future getLotByItemId(String itemId);
  // Future<int> confirmGoodsIssue(String issueid);
}
