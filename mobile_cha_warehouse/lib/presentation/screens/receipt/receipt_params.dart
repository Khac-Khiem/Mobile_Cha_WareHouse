// dùng để add container lên server
class GoodsReceiptEntryContainerData {
  String containerId;
  String employeeId;
  String itemId;
  int actualQuantity;
  String productionDate;
  GoodsReceiptEntryContainerData( this.containerId, this.employeeId, this.itemId,
      this.actualQuantity, this.productionDate);
  Map<String, dynamic> toJson() => {
        "containerId": containerId,
        "itemId": itemId,
        "employeeId": employeeId,
        "actualQuantity": actualQuantity,
        "productionDate": productionDate
      };
}

class LocationServer {
  String containerId;
  String shelfId;
  int? rowId;
  int? id;
  LocationServer(this.containerId, this.shelfId, this.rowId, this.id);
}

// class GoodsReceiptServer {
//   GoodsReceiptServer({
//     required this.goodsReceiptId,
//     required this.timestamp,
//     required this.containers,
//   });
//   late final String goodsReceiptId;
//   late final String timestamp;
//   late final List<Containers> containers;

//   GoodsReceiptServer.fromJson(Map<String, dynamic> json) {
//     goodsReceiptId = json['goodsReceiptId'];
//     timestamp = json['timestamp'];
//     containers = List.from(json['containers'])
//         .map((e) => Containers.fromJson(e))
//         .toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['goodsReceiptId'] = goodsReceiptId;
//     _data['timestamp'] = timestamp;
//     _data['containers'] = containers.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Containers {
//   Containers({
//     required this.itemId,
//     required this.employeeId,
//     required this.containerId,
//     required this.quantity,
//     required this.productionDate,
//   });
//   late final String itemId;
//   late final String employeeId;
//   late final String containerId;
//   late final int quantity;
//   late final String productionDate;

//   Containers.fromJson(Map<String, dynamic> json) {
//     itemId = json['itemId'];
//     employeeId = json['employeeId'];
//     containerId = json['containerId'];
//     quantity = json['quantity'];
//     productionDate = json['productionDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['itemId'] = itemId;
//     _data['employeeId'] = employeeId;
//     _data['containerId'] = containerId;
//     _data['quantity'] = quantity;
//     _data['productionDate'] = productionDate;
//     return _data;
//   }
// }
