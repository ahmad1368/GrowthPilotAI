/// "Extract Price, Quantity, Delivery Date" (Issue #152) — the values
/// this app can actually parse locally, never sent off-device.
typedef NegotiationTerms = ({double? price, int? quantity, DateTime? deliveryDate});

const NegotiationTerms emptyNegotiationTerms = (price: null, quantity: null, deliveryDate: null);
