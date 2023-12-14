@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view of Item Table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsalesorder_item_i as select from zsalesorder_item
association to parent zsalesorder_hdr_i as _SalesOrder
on $projection.Salesdocumentnumber = _SalesOrder.Salesdocumentnumber
{
    @EndUserText.label: 'Item Number'
    key itemnumber as Itemnumber,
    @EndUserText.label: 'Sales Document Number'
    key salesdocumentnumber as Salesdocumentnumber,
    @EndUserText.label: 'Item category'
    itemcateg as Itemcateg,
    @EndUserText.label: 'Material'
    material as Material,
    @EndUserText.label: 'Plant'
    plant as Plant,
    @EndUserText.label: 'Target Qty'
    targetqty as Targetqty,
    @EndUserText.label: 'Target Qu'
    targetqu as Targetqu,
    _SalesOrder
}
