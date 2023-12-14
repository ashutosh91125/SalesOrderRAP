@EndUserText.label: 'Consumption View for item'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI.headerInfo: {
  typeName:       'Purchase Order Item',
  typeNamePlural: 'Purchase Order Items',
  title: {
    type:   #STANDARD,
    value:  'Itemnumber'
  }
  }
define view entity zsalesorder_item_c as projection on zsalesorder_item_i
{
    @UI.facet: [{
        id: 'Item',
        purpose: #STANDARD,
        label: 'Item data',
        type : #IDENTIFICATION_REFERENCE,
        position : 10
        }]
      @UI: {
            lineItem: [{position: 10}],
            identification: [{position: 10}]
        }
    key Itemnumber,  
      @UI: {
            lineItem: [{position: 20}],
            identification: [{position: 20}]
        }
    key Salesdocumentnumber,
    
    @UI: {
            lineItem: [{position: 30}],
            identification: [{position: 30}]
        }
    Itemcateg,
    @UI: {
            lineItem: [{position: 40}],
            identification: [{position: 40}]
        }
    Material,
    @UI: {
            lineItem: [{position: 50}],
            identification: [{position: 50}]
        }
    Plant,
    @UI: {
            lineItem: [{position: 60}],
            identification: [{position: 60}]
        }
    Targetqty,
    @UI: {
            lineItem: [{position: 70}],
            identification: [{position: 70}]
        }
    Targetqu,
    /* Associations */
    _SalesOrder : redirected to parent zsalesorder_hdr_c
}
