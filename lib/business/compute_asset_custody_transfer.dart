import 'package:growth_pilot_ai/core/enum/asset_custody_status.dart';

/// Result of [ComputeAssetCustodyTransfer]: either the transfer is allowed,
/// or [error] explains why it's rejected.
class AssetCustodyTransferCheck {
  final String? error;

  const AssetCustodyTransferCheck._success() : error = null;
  const AssetCustodyTransferCheck._failure(this.error);

  bool get isValid => error == null;
}

/// Pure "Integrity" gate (Issue #157 Acceptance Criteria): an asset cannot
/// change custody while [AssetCustodyStatus.underMaintenance]. No I/O —
/// [TransferAssetCustody] wraps this in the actual ObjectBox write.
class ComputeAssetCustodyTransfer {
  static AssetCustodyTransferCheck call(AssetCustodyStatus currentStatus) {
    if (currentStatus == AssetCustodyStatus.underMaintenance) {
      return const AssetCustodyTransferCheck._failure(
          'Asset is under maintenance and cannot change custody.');
    }
    return const AssetCustodyTransferCheck._success();
  }
}
