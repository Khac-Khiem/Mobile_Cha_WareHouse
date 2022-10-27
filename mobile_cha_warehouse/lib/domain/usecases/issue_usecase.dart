import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/repositories/issue_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

import '../entities/lots_data.dart';

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

  Future<ErrorPackage> addContainerIssue(
      String issueId, List<Lots> lots) async {
    final confirm = _issuesRepo.addContainerIssue(issueId, lots);
    return confirm;
  }

  Future getLotByItemId(String itemId) async {
    final confirm = _issuesRepo.getLotByItemId(itemId);
    return confirm;
  }
}
