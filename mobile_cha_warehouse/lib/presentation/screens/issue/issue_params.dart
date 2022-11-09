class LotIssueExportServer {
  String issueId;
  String itemId;
  String lotId;
  double quantity;
  LotIssueExportServer(this.issueId, this.itemId, this.lotId, this.quantity);
}

class LotIssueExport {
  String issueId;
  String lotId;
  dynamic quantity;
  LotIssueExport(this.issueId, this.lotId, this.quantity);
}

class GoodsIssueEntryView {
  String itemId;
  num planQuantity;
  num actualQuantity;
  GoodsIssueEntryView(this.itemId, this.planQuantity, this.actualQuantity);
}
