@EndUserText.label: 'Consumption View for Message'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zsalesorder_msg_c as projection on zsalesorder_msg_i
{
    @UI.facet: [{
        id: 'message',
        purpose: #STANDARD,
        label: 'Message Log',
        type : #IDENTIFICATION_REFERENCE,
        position : 10
        }]
        
      @UI: {
            lineItem: [{position: 10}],
            identification: [{position: 10}]
      }
    key MessageNo,
    @UI: {
            lineItem: [{position: 20}],
            identification: [{position: 20}]
      }
    key Salesdocumentnumber,
    @UI: {
            lineItem: [{position: 40}],
            identification: [{position: 40}]
      }
    Comments,
    /* Associations */
    _SalesOrder : redirected to parent zsalesorder_hdr_c
}
