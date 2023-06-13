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
        cssClasses: {
            item: "w-100"
        },
        templates: {
            empty: "Keine Resultate für <q>{{ query }}</q>",
            item(hit, { html, components }) {
                return html` 
            <h2><a href='${hit.rec_id}'>${hit.title}</a></h2>
            <h3><a href='${hit.case_id}'>${hit.case.title}</a></h3>
            <p>${hit._snippetResult.full_text.matchedWords.length > 0 ? components.Snippet({ hit, attribute: 'full_text' }) : ''}</p>
            ${hit.persons.map((item) => html`<a href='${item.id}'><span class="badge rounded-pill m-1 bg-warning">${item.title}</span></a>`)}
            <br />
            ${hit.places.map((item) => html`<a href='${item.id}'><span class="badge rounded-pill m-1 bg-info">${item.title}</span></a>`)} 
            `;
            },
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
        container: "#refinement-list-related-persons",
        attribute: "case.related_persons.name_and_role",
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
        container: "#refinement-list-places",
        attribute: "places.title",
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

    instantsearch.widgets.sortBy({
        container: "#sort-by",
        items: [
            { label: "Dokument (aufsteigend)", value: "legalkraus/sort/rec_id:asc" },
            { label: "Dokument (absteigend)", value: "legalkraus/sort/rec_id:desc" },
            { label: "Akt (aufsteigend)", value: "legalkraus/sort/case_id:asc" },
            { label: "Akt (absteigende)", value: "legalkraus/sort/case_id:desc" },
        ],
    }),

    instantsearch.widgets.configure({
        hitsPerPage: 20,
        attributesToSnippet: ["full_text"],
    }),

]);

search.start();