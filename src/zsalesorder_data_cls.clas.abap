CLASS zsalesorder_data_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsalesorder_data_cls IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DELETE from zsalesorder_hdr.
  INSERT  zsalesorder_hdr  FROM TABLE @( VALUE #(
  (  salesdocumentnumber  = '104'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG'

 )
(
salesdocumentnumber  = '105'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG' )

(
salesdocumentnumber  = '106'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG' )

(
salesdocumentnumber  = '107'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG' )

(
salesdocumentnumber  = '108'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG')

(
salesdocumentnumber  = '109'
    DocType = 'OR'
SalesOrg = 'MC01'
SalesDist    = '000001'
DistrChan = '10'
Division   = '00'
ShipCond = '01'
AccntAsgn = '01'
PurchNoC = ''
partnnumb = '01'
partnrole = 'AG')
                        ) ).
  SELECT * FROM zsalesorder_hdr INTO TABLE @DATA(lt_sql_entries).
    out->write( 'Header data send Successfully' ).

  ENDMETHOD.
ENDCLASS.
