@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projektionview für Sprachen - Processor'
@UI: {
 headerInfo: { typeName: 'Language', typeNamePlural: 'Languages', title: { type: #STANDARD, value: 'LanguageID' } } }

@Search.searchable: true

define root view entity YC_LANGUAGE_M_13 
as projection on YI_LANGUAGE_M_13 {

       @UI.facet: [ { id:              'Language',
                      purpose:         #STANDARD,
                      type:            #IDENTIFICATION_REFERENCE,
                      label:           'Language',
                      position:        10 } ]
      @UI.hidden: true

  key mykey           as LanguageUUID,

      @UI: {
              lineItem:       [ { position: 10, importance: #HIGH } ],
              identification: [ { position: 10, label: 'Language ID' } ] }
      @Search.defaultSearchElement: true
      l_id     as LanguageID,

      @UI.lineItem: [{position:20 }]
      @UI.identification: [ { position: 20, label: 'Languagename' } ]
      l_name   as Name,
      
      
      @UI.identification: [ { position: 30, label: 'Snippet' } ]
      l_snippet         as Snippet,

      
      @UI.identification: [ { position: 40, label: 'Description' } ]
      l_description     as Description,
      
      @UI.lineItem: [{position: 50, type:#AS_DATAPOINT }]
      @UI.dataPoint: { title: 'Language Rating',
                        visualization: #RATING,
                        targetValue: 5}
      @UI.identification: [{position: 50, label: 'Rating [0-5]'}]
      l_rating          as Rating
}
