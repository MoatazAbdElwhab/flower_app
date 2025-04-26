class InvoiceData {
  final dynamic accountTaxIds;
  final dynamic customFields;
  final dynamic description;
  final dynamic footer;
  final dynamic issuer;
  final dynamic renderingOptions;

  const InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        accountTaxIds: json['account_tax_ids'] as dynamic,
        customFields: json['custom_fields'] as dynamic,
        description: json['description'] as dynamic,
        footer: json['footer'] as dynamic,
        issuer: json['issuer'] as dynamic,
        renderingOptions: json['rendering_options'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'account_tax_ids': accountTaxIds,
        'custom_fields': customFields,
        'description': description,
        'footer': footer,
        'issuer': issuer,
        'rendering_options': renderingOptions,
      };
}
