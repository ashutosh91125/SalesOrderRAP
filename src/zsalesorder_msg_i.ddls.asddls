@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Message table interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsalesorder_msg_i as select from zsalesorder_msg
association to parent zsalesorder_hdr_i as _SalesOrder
    on $projection.Salesdocumentnumber = _SalesOrder.Salesdocumentnumber
{   
    @EndUserText.label: 'Message No'
    key message_no as MessageNo,
    @EndUserText.label: 'Sales Document Number'
    key salesdocumentnumber as Salesdocumentnumber,
    @EndUserText.label: 'Comments'
    comments as Comments,
    _SalesOrder
}
