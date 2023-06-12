var project_collection_name = "legalkraus"
const typesenseInstantsearchAdapter = new TypesenseInstantSearchAdapter({
  server: {
    apiKey: "KJBQiMxhSviZKAKTWi9tNLdZ5pQjZpsa",
    nodes: [
      {
        host: "localhost",
        port: "8108",
        protocol: "http",
      },
    ],
  },
   additionalSearchParameters: {
    query_by: "full_text,title",
  },
});

const searchClient = typesenseInstantsearchAdapter.searchClient;
const search = instantsearch({
  searchClient,
  indexName: project_collection_name,
});

search.addWidgets([
  instantsearch.widgets.searchBox({
    container: "#searchbox",
    autofocus: true,
    cssClasses: {
      form: "form-inline",
      input: "form-control col-md-11",
      submit: "btn",
      reset: "btn",
    },
  }),

  instantsearch.widgets.hits({
    container: "#hits",
    templates: {
      empty: "Keine Resultate für <q>{{ query }}</q>",
      item: `
              <h4><a href="{{ rec_id }}">{{#helpers.snippet}}{ "attribute": "title", "highlightedTagName": "mark" }{{/helpers.snippet}}</a></h4>
              <h5>{{ case.title }}</h5>
              <p style="overflow:hidden;max-height:210px;">{{#helpers.snippet}}{ "attribute": "full_text", "highlightedTagName": "mark" }{{/helpers.snippet}}</p>
              <h5><span class="badge badge-primary">{{ project }}</span></h5>
              <div>
                  <div>
                      <span class="badge bg-secondary">{{ year }}</span>
                  </div>
              </div>
          `,
    },
  }),

  instantsearch.widgets.pagination({
    container: "#pagination",
  }),

  instantsearch.widgets.stats({
    container: "#stats-container",
    templates: {
      text: `
            {{#areHitsSorted}}
              {{#hasNoSortedResults}}keine Treffer{{/hasNoSortedResults}}
              {{#hasOneSortedResults}}1 Treffer{{/hasOneSortedResults}}
              {{#hasManySortedResults}}{{#helpers.formatNumber}}{{nbSortedHits}}{{/helpers.formatNumber}} Treffer {{/hasManySortedResults}}
              aus {{#helpers.formatNumber}}{{nbHits}}{{/helpers.formatNumber}}
            {{/areHitsSorted}}
            {{^areHitsSorted}}
              {{#hasNoResults}}keine Treffer{{/hasNoResults}}
              {{#hasOneResult}}1 Treffer{{/hasOneResult}}
              {{#hasManyResults}}{{#helpers.formatNumber}}{{nbHits}}{{/helpers.formatNumber}} Treffer{{/hasManyResults}}
            {{/areHitsSorted}}
            gefunden in {{processingTimeMS}}ms
          `,
    },
  }),

  instantsearch.widgets.refinementList({
    container: "#refinement-list-keywords",
    attribute: "case.keywords",
    searchable: true,
    searchablePlaceholder: "Suchen",
    cssClasses: {
      searchableInput: "form-control form-control-sm m-2 border-light-2",
      searchableSubmit: "d-none",
      searchableReset: "d-none",
      showMore: "btn btn-secondary btn-sm align-content-center",
      list: "list-unstyled",
      count: "badge m-2 badge-secondary hideme ",
      label: "d-flex align-items-center text-capitalize",
      checkbox: "m-2",
    },
  }),

  instantsearch.widgets.refinementList({
    container: "#refinement-list-persons",
    attribute: "persons.title",
    searchable: true,
    cssClasses: {
      showMore: "btn btn-secondary btn-sm align-content-center",
      list: "list-unstyled",
      count: "badge m-2 badge-secondary hideme",
      label: "d-flex align-items-center",
      checkbox: "m-2",
    },
  }),

  instantsearch.widgets.refinementList({
    container: "#refinement-list-case",
    attribute: "case.title",
    searchable: true,
    searchablePlaceholder: "Suchen",
    cssClasses: {
      showMore: "btn btn-secondary btn-sm align-content-center",
      list: "list-unstyled",
      count: "badge m-2 badge-secondary hideme",
      label: "d-flex align-items-center text-capitalize",
      checkbox: "m-2",
    },
  }),

  instantsearch.widgets.refinementList({
    container: "#refinement-list-materials",
    attribute: "materials",
    searchable: true,
    cssClasses: {
      showMore: "btn btn-secondary btn-sm align-content-center",
      list: "list-unstyled",
      count: "badge m-2 badge-secondary hideme",
      label: "d-flex align-items-center text-capitalize",
      checkbox: "m-2",
    },
  }),

//   instantsearch.widgets.rangeInput({
//     container: "#refinement-range-year",
//     attribute: "creation_year",
//     templates: {
//       separatorText: "to",
//       submitText: "Suchen",
//     },
//     cssClasses: {
//       form: "form-inline",
//       input: "form-control",
//       submit: "btn",
//     },
//   }),

  instantsearch.widgets.pagination({
    container: "#pagination",
    padding: 2,
    cssClasses: {
      list: "pagination",
      item: "page-item",
      link: "page-link",
    },
  }),

  instantsearch.widgets.clearRefinements({
    container: "#clear-refinements",
    templates: {
      resetLabel: "Filter zurücksetzen",
    },
    cssClasses: {
      button: "btn",
    },
  }),

  instantsearch.widgets.currentRefinements({
    container: "#current-refinements",
    cssClasses: {
      delete: "btn",
      label: "badge",
    },
  }),

//   instantsearch.widgets.sortBy({
//     container: "#sort-by",
//     items: [
//       //{ label: "Default", value: `${project_collection_name}/sort/creation_date:asc, bv_doc_id_num:asc, doc_internal_orderval:asc` },
//       { label: "chronologisch", value: `${project_collection_name}/sort/creation_date:asc, bv_doc_id_num:asc, doc_internal_orderval:asc` },
//       { label: "umgekehrt chronologisch", value: `${project_collection_name}/sort/creation_date:desc, bv_doc_id_num:asc, doc_internal_orderval:asc` },
//     ],
//   }),

  instantsearch.widgets.configure({
    hitsPerPage: 8,
    attributesToSnippet: ["full_text"],
    //filters: function() { return document.getElementsByTagName("input").value },
  }),

]);

search.start();

//'doc_internal_orderval: 1'  