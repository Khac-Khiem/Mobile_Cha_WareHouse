import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

class IssueUseCase {
  final IssuesRepo _issuesRepo;
  IssueUseCase(this._issuesRepo);
  Future<List<GoodsIssue>> getAllIssues() async {
    final goodsissues = await _issuesRepo.getGoodsIssues();
    return goodsissues;
  }

  Future<GoodsIssue> getIssueById(String id) async {
    final goodsIssue = await _issuesRepo.getGoodsIssueById(id);
    return goodsIssue;
  }

  Future addContainerIssue(
      String issueId, List<ContainerIssueExportServer> containers) async {
    final confirm = _issuesRepo.addContainerIssue(issueId, containers);
    return confirm;
  }

  Future confirmGoodsIssue(String issueId) async {
    final goodsissues = await _issuesRepo.confirmGoodsIssue(issueId);
    return goodsissues;
  }
}
