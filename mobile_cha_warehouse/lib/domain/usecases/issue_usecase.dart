import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';

class IssueUseCase {
  final IssuesRepo _issuesRepo;
  IssueUseCase(this._issuesRepo);
  Future<List<GoodsIssue>> getAllIssues(String startDate) async {
    final goodsissues = await _issuesRepo.getGoodsIssues(startDate);
    return goodsissues;
  }

  Future<GoodsIssue> getIssueById(String id) async {
    final goodsIssue = await _issuesRepo.getGoodsIssueById(id);
    return goodsIssue;
  }

 

  Future<void> patchConfirmIssueEntry(String issueId,
      List<String> goodIssueId) async {
   final confirm = _issuesRepo.patchConfirmIssue(issueId ,goodIssueId);
  }
}
