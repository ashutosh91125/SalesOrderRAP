@EndUserText.label: 'Consumption View for header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI.headerInfo: {
  typeName:       'Sales Order',
  typeNamePlural: 'Sales Order List',
  title: {
    type:   #STANDARD,
    value:  'Salesdocumentnumber'
  }
}
define root view entity zsalesorder_hdr_c
  provider contract transactional_query as projection on zsalesorder_hdr_i
{
    @UI.facet: [{
      id: 'SalesOrder',
      purpose: #STANDARD,
      label: 'Sales Order',
      type : #IDENTIFICATION_REFERENCE,
      position : 10
      },{
      id: 'item',
      purpose: #STANDARD,
      label : 'Order Item',
      type : #LINEITEM_REFERENCE,
      position : 20,
      targetElement : '_Item'
      },{
        id: 'comment',
        purpose: #STANDARD,
        label : 'Message Log',
        type : #LINEITEM_REFERENCE,
        position : 30,
        targetElement : '_Message'
        }]
      @UI: {
          selectionField : [{position: 10}],
          lineItem: [{position: 10}],
          identification: [{position: 10}]
      }
    key Salesdocumentnumber,
    @UI: {
          lineItem: [{position: 20}],
          identification: [{position: 20}]
      }
    
    Doctype,
    @UI: {
          lineItem: [{position: 30}],
          identification: [{position: 30}]
      }
    Salesorg,
    @UI: {
          lineItem: [{position: 40}],
          identification: [{position: 40}]
      }
    Salesdist,
    @UI: {
          lineItem: [{position: 50}],
          identification: [{position: 50}]
      }
    Distrchan,
    @UI: {
          lineItem: [{position: 60}],
          identification: [{position: 60}]
      }
    Division,
    @UI: {
          lineItem: [{position: 70}],
          identification: [{position: 70}]
      }
    Shipcond,
    @UI: {
          lineItem: [{position: 80}],
          identification: [{position: 80}]
      }
    Accntasgn,
    @UI: {
          lineItem: [{position: 90}],
          identification: [{position: 90}]
      }
    Purchnoc,
    @UI: {
          lineItem: [{position: 100}],
          identification: [{position: 100}]
      }
    Partnnumb,
    @UI: {
          lineItem: [{position: 110}],
          identification: [{position: 110}]
      }
    Partnrole,
    @UI: {
            selectionField : [{position: 20}],
            lineItem : [{position: 120,criticality:'criticality', importance: #HIGH},{ type: #FOR_ACTION, dataAction: 'transferData', label: 'Transfer Data' }

            ],
            identification: [{position: 120}]

        }
       
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zsales_status', element: 'Value' },
      distinctValues: true,
      additionalBinding: [{ localElement: 'Statusdesc', element: 'Description', usage: #FILTER_AND_RESULT }] }]
      @ObjectModel.text.element:  [ 'Statusdesc' ]
      @UI.textArrangement: #TEXT_ONLY
      Status,
      criticality,
      @Semantics.text: true
      Statusdesc,
      CreatedBy,
      @UI: {

            lineItem: [{position: 520}],
            identification: [{position: 520}]

        }
      CreatedAt,
    /* Associations */
    _Item : redirected to composition child zsalesorder_item_c,
    _Message : redirected to composition child zsalesorder_msg_c
}
