CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

    METHODS transferData FOR MODIFY
      IMPORTING keys FOR ACTION SalesOrder~transferData RESULT result.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD transferData.
    LOOP AT keys INTO DATA(ls_key).

      SELECT * FROM zsalesorder_hdr WHERE salesdocumentnumber = @ls_key-Salesdocumentnumber

      INTO TABLE @DATA(lt_salesorder_header).

      SELECT * FROM zsalesorder_item WHERE salesdocumentnumber = @ls_key-Salesdocumentnumber

      INTO TABLE @DATA(lt_salesorder_item).

      DATA lv_payload TYPE string.
      DATA lv_payload_item TYPE string.
      DATA lv_payload_partner TYPE string.

      LOOP AT lt_salesorder_header INTO DATA(ls_salesorder_header).

        CLEAR lv_payload.

        lv_payload =
         `{ ` &&
         `"toHeader" : [{ ` &&
         `"SalesDocumentNumber" : "` && ls_salesorder_header-salesdocumentnumber && `",` &&
         `"DocType" : "` && ls_salesorder_header-doctype && `",` &&
         `"SalesOrg" : "` && ls_salesorder_header-salesorg && `",` &&
         `"SalesDist" : "` && ls_salesorder_header-salesdist && `",` &&
         `"DistrChan" : "` && ls_salesorder_header-distrchan && `",` &&
         `"Division" : "` && ls_salesorder_header-division && `",` &&
         `"ShipCond" : "` && ls_salesorder_header-shipcond && `",` &&
         `"AccntAsgn" : "` && ls_salesorder_header-accntasgn && `",` &&
         `"PurchNoC" : "` && ls_salesorder_header-purchnoc && `"}],` &&
         `"toItem" : [`.

        CLEAR lv_payload_item.
        LOOP AT  lt_salesorder_item INTO DATA(ls_salesorder_item) WHERE salesdocumentnumber = ls_salesorder_header-salesdocumentnumber.
          IF lv_payload_item IS NOT  INITIAL.
            lv_payload_item = lv_payload_item && ','.
          ENDIF.
          lv_payload_item = lv_payload_item &&

             `{ "SalesDocumentNumber" : "` && ls_salesorder_item-salesdocumentnumber && `",` &&
             `"ItmNumber" : "` && ls_salesorder_item-itemnumber && `",  ` &&
             `"ItemCateg" : "` && ls_salesorder_item-itemcateg && `",   ` &&
             `"Material" : "` && ls_salesorder_item-material && `",   ` &&
             `"Plant" : "` && ls_salesorder_item-plant && `",   ` &&
             `"TargetQty" : "` && ls_salesorder_item-targetqty && `",` &&
             `"TargetQu" : "` && ls_salesorder_item-targetqu && `"}],` &&

             `"toPartner" : [`.

          CLEAR lv_payload_partner.
          LOOP AT  lt_salesorder_header INTO DATA(ls_salesorder_partner).
            IF lv_payload_partner IS NOT  INITIAL.
              lv_payload_partner = lv_payload_partner && ','.
            ENDIF.

            lv_payload_partner = lv_payload_partner &&
               `{ "SalesDocumentNumber" : "` &&  ls_salesorder_partner-salesdocumentnumber && `",` &&
               `  "PartnNumb" : "` &&  ls_salesorder_partner-partnnumb && `",` &&
               ` "PartnRole" : "` && ls_salesorder_partner-partnrole && `" }] }` .

          ENDLOOP.
          lv_payload_item = lv_payload_item && lv_payload_partner.

        ENDLOOP.
        lv_payload = lv_payload && lv_payload_item.
      ENDLOOP.

      TRY.
          DATA(http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination =
          cl_http_destination_provider=>create_by_url( i_url =
        'http://71.251.192.136:8011//sap/opu/odata/sap/ZAPI_SALES_ORDER_SRV/SalesOrderSet' ) ).

        CATCH cx_web_http_client_error cx_http_dest_provider_error.
          "handle exception
      ENDTRY.

      http_client->get_http_request( )->set_authorization_basic(
          i_username = 'hpratap'
          i_password = 'Programming@1234'

       ).

      http_client->get_http_request(
            RECEIVING
              r_http_request = DATA(lo_request) ).

      lo_request->set_header_field(

    EXPORTING

      i_name  =  'X-CSRF-Token'                " Name of the header field

      i_value =  'Fetch'   ).

      TRY.
          http_client->execute(
            EXPORTING
              i_method   = if_web_http_client=>get
            RECEIVING
              r_response = DATA(lo_response) ).
        CATCH cx_web_http_client_error.

      ENDTRY.

      DATA(lv_token)    = lo_response->get_header_field('X-CSRF-Token').

      lo_request->set_header_field(

    EXPORTING

      i_name  = 'X-CSRF-Token'                " Name of the header field

      i_value =    lv_token  ).

      lo_request->set_header_field(
      EXPORTING
      i_name  = 'Content-Type'
      i_value = 'application/json'
      ).


      TRY.
          lo_request->set_text(
            EXPORTING
              i_text   = lv_payload ).
        CATCH cx_web_message_error.
      ENDTRY.

      TRY.
          http_client->execute(
            EXPORTING
              i_method   = if_web_http_client=>post
            RECEIVING
              r_response = lo_response ).
        CATCH cx_web_http_client_error.

      ENDTRY.

      TRY.
          lo_response->get_status(
          RECEIVING
            r_value = DATA(ls_resp_status) ).
        CATCH cx_web_message_error.
      ENDTRY.

      TRY.
          lo_response->get_text(
            RECEIVING
              r_value = DATA(lv_response) ).
        CATCH cx_web_message_error.

      ENDTRY.

       GET TIME STAMP FIELD DATA(lv_created_on).

      DELETE FROM zsalesorder_msg WHERE salesdocumentnumber = @ls_key-Salesdocumentnumber.

      IF ls_resp_status-code = '200' OR ls_resp_status-code = '201'.

        UPDATE zsalesorder_hdr SET status =  3  , created_by = @sy-uname , created_at = @lv_created_on WHERE salesdocumentnumber = @ls_key-Salesdocumentnumber.

      ELSE.
        UPDATE zsalesorder_hdr SET status = 4 , created_by = @sy-uname , created_at = @lv_created_on WHERE salesdocumentnumber = @ls_key-Salesdocumentnumber.

        DATA ls_message TYPE zsalesorder_msg.

      ENDIF.

      ls_message-message_no = 1.

      ls_message-salesdocumentnumber = ls_key-Salesdocumentnumber.


      SPLIT lv_response AT '<message xml:lang="en">' INTO DATA(lv_xml_part1) DATA(lv_exml_part2).
      SPLIT lv_exml_part2 AT '</message>' INTO DATA(lv_error_message) lv_exml_part2.

      ls_message-comments = lv_error_message.

      INSERT zsalesorder_msg FROM @ls_message.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
