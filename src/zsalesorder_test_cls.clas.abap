CLASS zsalesorder_test_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsalesorder_test_cls IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DELETE FROM zsalesorder_msg WHERE salesdocumentnumber = ''.
  out->write( 'Done' ).

  ENDMETHOD.
ENDCLASS.
