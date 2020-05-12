@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projektionview für Sprachen - Processor'
@UI: {
 headerInfo: { typeName: 'About the language', typeNamePlural: 'Languages', title: { type:#STANDARD, value: 'Name' } } }

@Search.searchable: true

define root view entity YC_LANGUAGE_M_13
  as projection on YI_LANGUAGE_M_13
{

      @UI.facet: [ { id:              'Language',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Language',
                     position:        10 } ]
      @UI.hidden: true

      key mykey         as LangugageUUID,
  
      @UI.facet: [ { id:           'idHeaderRating',
                     purpose:         #HEADER,
                     type:            #DATAPOINT_REFERENCE,
                     position:        10,
                     targetQualifier: 'Rating' } ]

      @UI: {
              lineItem:       [ { position: 10, importance: #HIGH, label: ' ID ' } ],
              identification: [ { position: 10, label: 'Language ID' } ] }
      @Search.defaultSearchElement: false
      l_id          as LanguageID,

      @UI: {
              lineItem: [{position:30, label: 'Name' }],
              identification: [ { position: 30, label: 'Language name' } ] }
      l_name        as Name,

      @UI: {
              lineItem: [{position: 40, type:#AS_DATAPOINT }],
              dataPoint: { title: 'Language Rating',
                           visualization: #RATING,
                           targetValue: 5},
              identification: [{position: 40, label:'Rating [1..5 Stars]' }] }
      @Search.defaultSearchElement: true
      l_rating      as Rating,

      @UI: {
              lineItem:       [ { position: 50},
                                { type:#FOR_ACTION,  dataAction: 'addToFavourite', label: 'Favourite' } ],
             
              identification: [ { position: 50, label: 'Favourite [F(Favourite) / <empty>]' } ]  }
      @Search.defaultSearchElement: true
      l_favourite   as Favourite,

      @UI.identification: [ { position: 60, label: 'Hello World' } ]
      l_snippet     as Snippet,


      @UI: {
               lineItem:       [ { position: 70 } ],
               identification: [ { position: 70, label: 'Description' } ]}
      @Search.defaultSearchElement: true
      l_description as Description,
      
      @UI.identification: [ { position: 80, label: 'IDE' } ]
      @Search.defaultSearchElement: true
      l_ide as IDE,
      
      @UI.identification: [ { position: 80, label: 'Wikipedia URL' } ]
      l_wikipedia as WikipediaURL
}
