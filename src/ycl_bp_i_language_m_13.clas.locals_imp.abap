*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_language DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    TYPES tt_language_update TYPE TABLE FOR UPDATE yi_language_m_13.

    METHODS validate_name              FOR VALIDATION language~validateName      IMPORTING keys FOR language.
    METHODS validate_rating            FOR VALIDATION language~validateRating    IMPORTING keys FOR language.
    "METHODS validate_id                FOR VALIDATION language~validateId        IMPORTING keys FOR language.
    METHODS set_status_completed       FOR MODIFY IMPORTING   keys FOR ACTION language~addToFavourite              RESULT result.
    METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR language    RESULT result.

    METHODS CalculateLanguageKey FOR DETERMINATION language~CalculateLanguageKey IMPORTING keys FOR language.



ENDCLASS.

CLASS lhc_language IMPLEMENTATION.


**********************************************************************
*
* Check name
*
**********************************************************************
  METHOD validate_name.

    READ ENTITY yi_language_m_13\\language FROM VALUE #(
    FOR <root_key> IN keys ( %key     = <root_key>
                                   %control = VALUE #( l_id = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_language).

    DATA lt_languages TYPE SORTED TABLE OF ylanguage_13 WITH UNIQUE KEY l_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    "DELETE lt_languages WHERE l_name CA 'ÄäÖöÜüß'.

     LOOP AT lt_language INTO DATA(ls_language).
      IF ls_language-l_name CA 'ÄäÖöÜüß'.
        APPEND VALUE #(  mykey = ls_language-mykey ) TO failed.
        APPEND VALUE #(  mykey = ls_language-mykey
                         %msg      = new_message( id       = 'YHSKA13'
                                                  number   = '001'
                                                  v1       = ls_language-l_name
                                                  severity = if_abap_behv_message=>severity-error )
                         %element-l_name = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

**********************************************************************
*
* Check rating
*
**********************************************************************
  METHOD validate_rating.

    READ ENTITY yi_language_m_13\\language FROM VALUE #(
    FOR <root_key> IN keys ( %key     = <root_key>
                                   %control = VALUE #( l_id = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_language).

    DATA lt_languages TYPE SORTED TABLE OF ylanguage_13 WITH UNIQUE KEY l_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    "DELETE lt_languages WHERE l_name CA 'ÄäÖöÜüß'.

     LOOP AT lt_language INTO DATA(ls_language).
     IF NOT ls_language-l_rating CO ''.
      IF NOT ls_language-l_rating CA '12345'.
        APPEND VALUE #(  mykey = ls_language-mykey ) TO failed.
        APPEND VALUE #(  mykey = ls_language-mykey
                         %msg      = new_message( id       = 'YHSKA13'
                                                  number   = '002'
                                                  v1       = ls_language-l_rating
                                                  severity = if_abap_behv_message=>severity-error )
                         %element-l_name = if_abap_behv=>mk-on ) TO reported.
      ENDIF.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.


********************************************************************************
*
* Implements language action
*
********************************************************************************
  METHOD set_status_completed.

    " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF yi_language_m_13 IN LOCAL MODE
           ENTITY language
              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
                                                     l_favourite = 'F'
                                                     %control-l_favourite = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.


    " Read changed data for action result
    READ ENTITIES OF yi_language_m_13 IN LOCAL MODE
         ENTITY language
         FROM VALUE #( FOR key IN keys (  mykey = key-mykey
                                          %control = VALUE #(
                                            l_id       = if_abap_behv=>mk-on
                                            l_name     = if_abap_behv=>mk-on
                                            l_description = if_abap_behv=>mk-on
                                            l_snippet = if_abap_behv=>mk-on
                                            l_rating = if_abap_behv=>mk-on
                                            l_ide = if_abap_behv=>mk-on
                                            l_favourite = if_abap_behv=>mk-on
                                            ) ) )
         RESULT DATA(lt_language).

    result = VALUE #( FOR language IN lt_language ( mykey = language-mykey
                                                %param    = language
                                              ) ).

  ENDMETHOD.

********************************************************************************
*
* Implements the dynamic feature handling for travel instances
*
********************************************************************************
  METHOD get_features.

    "%control-<fieldname> specifies which fields are read from the entities

    READ ENTITY yi_language_m_13 FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                        " %control-l_id           = if_abap_behv=>mk-on
                                                         "%control-overall_status = if_abap_behv=>mk-on
                                                         %control-l_favourite = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_language_result).


    result = VALUE #( FOR ls_language IN lt_language_result
                       ( %key                           = ls_language-%key
                         %features-%action-addToFavourite = COND #( WHEN ls_language-l_favourite = 'F'
                                                                    THEN if_abap_behv=>fc-o-disabled
                                                                    ELSE if_abap_behv=>fc-o-enabled   )
                      ) ).
    MODIFY ENTITIES OF yi_language_m_13 IN LOCAL MODE
           ENTITY language
              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
                                                     l_favourite = ' '
                                                     %control-l_favourite = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

  ENDMETHOD.


  METHOD calculatelanguagekey.


    SELECT FROM ylanguage_13
        FIELDS MAX( l_id ) INTO @DATA(lv_max_language_id).

    LOOP AT keys INTO DATA(ls_key).
      lv_max_language_id = lv_max_language_id + 1.

      MODIFY ENTITIES OF yi_language_m_13  IN LOCAL MODE
        ENTITY Language
          UPDATE SET FIELDS WITH VALUE #( ( mykey  =  ls_key-mykey
                                            l_id = lv_max_language_id ) )


          REPORTED DATA(ls_reported).
      APPEND LINES OF ls_reported-language TO reported-language.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
