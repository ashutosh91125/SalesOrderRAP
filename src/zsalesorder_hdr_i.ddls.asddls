@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for header table'
define root view entity zsalesorder_hdr_i as select from zsalesorder_hdr
composition [1..*] of zsalesorder_item_i as _Item
composition [1..*] of zsalesorder_msg_i as _Message
association to zsales_status as _Status
 on $projection.Status = _Status.Value
{
    @EndUserText.label: 'Sales Document Number'
    key salesdocumentnumber as Salesdocumentnumber,
    @EndUserText.label: 'Document Type'
    doctype as Doctype,
    @EndUserText.label: 'Sales Orgnization'
    salesorg as Salesorg,
    @EndUserText.label: 'Sales Dist'
    salesdist as Salesdist,
    @EndUserText.label: 'Distrchan'
    distrchan as Distrchan,
    @EndUserText.label: 'Division'
    division as Division,
    @EndUserText.label: 'Shipcond'
    shipcond as Shipcond,
    @EndUserText.label: 'Account Assignment'
    accntasgn as Accntasgn,
    @EndUserText.label: 'Purchase NOC'
    purchnoc as Purchnoc,
    @EndUserText.label: 'Partner Number'
    partnnumb as Partnnumb,
    @EndUserText.label: 'Partner Role'
    partnrole as Partnrole,
    @EndUserText.label: 'Status'
    status as Status,
    case status
      when '0' then 0 
      when '3' then 1
      when '4' then 3
      else 0 
      end as criticality,
      @EndUserText.label: 'Created By'
      created_by as CreatedBy,
      @EndUserText.label: 'Created At'
    created_at as CreatedAt,
    _Status,
    @EndUserText.label: 'Status Description'
    _Status.Description as Statusdesc,
    _Item,
    _Message // Make association public
}
