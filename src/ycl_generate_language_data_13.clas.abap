CLASS ycl_generate_language_data_13 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_generate_language_data_13 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA:itab TYPE TABLE OF ylanguage_13.

*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(
  ( mykey = '02D5290E594C1EDA93815057FD946624' l_id = '1' l_name = 'Java' l_description = 'Beschreibung hier' l_snippet = 'snippet' l_rating = '5' )
  ( mykey = '02D5290E594C1EDA93815C50CD7AE62A' l_id = '2' l_name = 'C' l_description = 'Beschreibung hier' l_snippet = 'snippet' l_rating = '3' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B' l_id = '3' l_name = 'Python' l_description = 'Beschreibung hier' l_snippet = 'snippet' l_rating = '1' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB1B' l_id = '4' l_name = 'JavaScript' l_description = 'Beschreibung hier' l_snippet = 'snippet' l_rating = '2' )
  ).

*   delete existing entries in the database table
    DELETE FROM ylanguage_13.

*   insert the new table entries
    INSERT ylanguage_13 FROM TABLE @itab.

*   check the result
    SELECT * FROM ylanguage_13 INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Language data inserted successfully!').
  ENDMETHOD.
ENDCLASS.
