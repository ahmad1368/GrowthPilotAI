import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/compute_asset_custody_transfer.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_custody_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/enum/asset_custody_status.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:objectbox/objectbox.dart';

/// Hands an asset off between team members (Issue #157), rejecting the
/// transfer while under maintenance and appending both a custody record
/// and an entry to the shared audit trail (#343).
class TransferAssetCustody {
  static OmniResult<AssetCustodyRecordEntity> call(
    Store store,
    String itemName,
    String fromCustodianId,
    String toCustodianId,
    AssetCustodyStatus currentStatus,
    DateTime now,
  ) async {
    final check = ComputeAssetCustodyTransfer.call(currentStatus);
    if (!check.isValid) {
      return OmniResponse.error(check.error!, statusCode: 409);
    }
    final record = AssetCustodyRecordEntity(
      itemName: itemName,
      fromCustodianId: fromCustodianId,
      toCustodianId: toCustodianId,
      transferredAt: now,
    )..statusAtTransfer = currentStatus;

    try {
      store.runInTransaction(TxMode.write, () {
        store.box<AssetCustodyRecordEntity>().put(record);
        AuditLogRepository(store.box<AuditLogEntity>()).record(BuildAuditLogEntry.call(
          adminId: toCustodianId,
          changeType: 'ASSET_TRANSFER',
          targetMerchant: itemName,
          previousValue: fromCustodianId,
          newValue: toCustodianId,
          timestamp: now,
        ));
      });
      return OmniResponse.success(record);
    } catch (e) {
      return OmniResponse.error(e.toString());
    }
  }
}
