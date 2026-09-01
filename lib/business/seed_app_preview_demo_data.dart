import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/canadian_province.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

/// One clean, 100%-mock Canadian transaction (Issue #195's "Golden Path"
/// storyboard: scanned vendor invoice, GST/HST, Total CAD) for whoever
/// records the App Preview video to have camera-ready demo data instead
/// of typing it in by hand. This seeds app *data* only — it does not
/// produce the video itself (screen capture/editing/mockup framing are
/// outside what this pipeline can produce).
class SeedAppPreviewDemoData {
  static UnifiedTransactionEntity call() {
    const subtotal = 1240.0;
    final tax = CalculateGstPst.call(subtotal, applyPst: false, province: CanadianProvince.ontario);
    return UnifiedTransactionEntity(
      externalId: 'app-preview-demo-toronto-office-supplies',
      dbSource: TransactionSource.manualScan.index,
      amount: double.parse((subtotal + tax.total).toStringAsFixed(2)),
      date: DateTime.now(),
      merchantName: 'Staples Canada — Toronto',
      gst: tax.gst,
      pst: tax.pst,
      hst: tax.hst,
    );
  }
}
