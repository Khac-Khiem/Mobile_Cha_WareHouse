import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

abstract class IssuesRepo {
  Future<List<GoodsIssue>> getGoodsIssues();
  Future<GoodsIssue> getGoodsIssueById(String goodsIssueId);
  Future<int> addContainerIssue(
      String issueId, List<ContainerIssueExportServer> containers);
  Future<int> confirmGoodsIssue(String issueid);
}
