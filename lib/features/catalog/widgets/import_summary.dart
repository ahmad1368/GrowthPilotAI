/// One failed CSV row and why (Issue #141).
typedef ImportRowError = ({int row, String error});

/// The result of a bulk CSV import — "450 items imported, 12 failed"
/// (Issue #141, acceptance criterion "Success summary").
typedef ImportSummary = ({int importedCount, List<ImportRowError> errors});
