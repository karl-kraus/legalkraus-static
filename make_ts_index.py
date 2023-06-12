import glob
import os
from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm


schema_name = "legalkraus"


cases = sorted(glob.glob("./data/cases_tei/C_*.xml"))
editions_dir = "./data/editions"

records = []
for x in tqdm(cases[:3]):
    case_id = os.path.split(x)[-1]
    doc = TeiReader(x)
    nsmap = doc.nsmap
    case = {}
    case["title"] = doc.any_xpath(".//tei:title[1]/text()")[0]
    case["id"] = case_id.replace(".xml", "")
    case["resolver"] = case_id.replace(".xml", ".html")
    docs = doc.any_xpath(".//tei:sourceDesc/tei:list/tei:item/tei:ref/text()")
    case["nr_of_docs"] = len(docs)
    case["abstract"] = " ".join(doc.any_xpath(".//tei:abstract//text()"))
    for y in docs[:2]:
        try:
            soc = TeiReader(os.path.join(editions_dir, y))
        except Exception as e:
            print(y, e)
            continue
        body = soc.any_xpath('.//tei:body')[0]
        item = {}
        item["id"] = y.replace(".xml", "")
        item["rec_id"] = y.replace(".xml", ".html")
        item["case"] = case
        item["title"] = soc.any_xpath(".//tei:titleStmt/tei:title[1]/text()")[0]
        item["full_text"] = " ".join(" ".join(body.itertext()).split())
        item["places"] = []
        for place in soc.any_xpath('.//tei:listPlace/tei:place'):
            pl = {}
            pl["id"] = place.attrib["{http://www.w3.org/XML/1998/namespace}id"]
            pl["title"] = place.xpath('./tei:placeName[1]/text()', namespaces=nsmap)[0]
            item["places"].append(pl)


print(item)


# try:
#     client.collections[schema_name].delete()
# except ObjectNotFound:
#     pass

# current_schema = {
#     "name": schema_name,
#     "enable_nested_fields": True,
#     "fields": [
#         {"name": "id", "type": "string"},
#         {"name": "rec_id", "type": "string"},
#         {"name": "title", "type": "string"},
#         {"name": "full_text", "type": "string"},
#         {"name": "case", "type": "object", "facet": True},
#         {
#             "name": "year",
#             "type": "int32",
#             "optional": True,
#             "facet": True,
#         },
#         {"name": "persons", "type": "object[]", "facet": True, "optional": True},
#         {"name": "places", "type": "object[]", "facet": True, "optional": True},
#         {"name": "orgs", "type": "object[]", "facet": True, "optional": True},
#     ],
# }

# client.collections.create(current_schema)


# records = []

# make_index = client.collections[schema_name].documents.import_(records)
# print(make_index)
# print(f"done with indexing {schema_name}")
