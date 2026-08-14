/// The downloadable `.csv` template's contents (Issue #141,
/// acceptance criterion "Users can download a .csv template").
class BuildProductImportTemplate {
  static String call() {
    return 'name,sku,category,industry,price\n'
        'Espresso Machine,ESP-1000,Appliances,Retail,249.99\n';
  }
}
