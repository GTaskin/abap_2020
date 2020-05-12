@AbapCatalog.sqlViewName: 'YVI_LANGUAGE_M'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Datenmodel für Sprachen'
define root  view YI_LANGUAGE_M_13
as select from ylanguage_13 as Language {
    key mykey,
    l_id,
    l_name,
    l_description,
    l_snippet,
    l_rating,
    l_ide,
    l_favourite,
    l_wikipedia
   
}
