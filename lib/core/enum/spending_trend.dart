/// Direction of a spending trend derived from the regression slope (m).
enum SpendingTrend {
  rising, // m > 0  — burn rate is increasing
  falling, // m < 0  — spending is cooling down
  flat, // m == 0 — steady spending
}
