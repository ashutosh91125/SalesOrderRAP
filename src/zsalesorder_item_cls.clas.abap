CLASS zsalesorder_item_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsalesorder_item_cls IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DELETE from zsalesorder_item.
  INSERT  zsalesorder_item  FROM TABLE @( VALUE #(
  (
 salesdocumentnumber  = '104'
  ItemNumber = '1'
ItemCateg = 'TAN'
Material   = '41'
Plant = ''
TargetQty   = '1'
TargetQu = 'EA'
)
(
  salesdocumentnumber  = '105'
  ItemNumber = '1'
ItemCateg = 'TAN'
Material   = '41'
Plant = ''
TargetQty   = '1'
TargetQu = 'EA' )

(
  salesdocumentnumber  = '106'
  ItemNumber = '1'
ItemCateg = 'TAN'
Material   = '41'
Plant = ''
TargetQty   = '1'
TargetQu = 'EA' )

(
  salesdocumentnumber  = '107'
  ItemNumber = '1'
ItemCateg = 'TAN'
Material   = '41'
Plant = ''
TargetQty   = '1'
TargetQu = 'EA' )

(
  salesdocumentnumber  = '108'
  ItemNumber = '1'
ItemCateg = 'TAN'
Material   = '41'
Plant = ''
TargetQty   = '1'
TargetQu = 'EA' )
                        ) ).
  SELECT * FROM zsalesorder_item INTO TABLE @DATA(lt_sql_entries).
    out->write( ' Run Successful' ).

  ENDMETHOD.
ENDCLASS.
