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
for x in tqdm(cases):
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
    case["keywords"] = doc.any_xpath(".//tei:textClass/tei:keywords/tei:term/text()")
    case["related_persons"] = []
    for rel in doc.any_xpath(
        ".//tei:teiHeader/tei:profileDesc/tei:particDesc/tei:listPerson/tei:person"
    ):
        rel_ent = {}
        rel_ent["title"] = rel.xpath("./tei:persName/text()", namespaces=nsmap)[0]
        rel_ent["id"] = rel.attrib["sameAs"][1:]
        rel_ent["role_url"] = rel.attrib["role"]
        rel_ent["role"] = rel.xpath("./tei:note/text()", namespaces=nsmap)[0]
        rel_ent["name_and_role"] = f'{rel_ent["title"]} ({rel_ent["role"]})'
        case["related_persons"].append(rel_ent)
    for y in docs:
        try:
            soc = TeiReader(os.path.join(editions_dir, y))
        except Exception as e:
            print(y, e)
            continue
        body = soc.any_xpath(".//tei:body")[0]
        item = {}
        item["id"] = y.replace(".xml", "")
        item["rec_id"] = y.replace(".xml", ".html")
        item["case"] = case
        item["title"] = soc.any_xpath(".//tei:titleStmt/tei:title[1]/text()")[0]
        item["full_text"] = " ".join(" ".join(body.itertext()).split())

        item["places"] = []
        for entity_node in soc.any_xpath(".//tei:listPlace/tei:place"):
            entity = {}
            entity["id"] = entity_node.attrib[
                "{http://www.w3.org/XML/1998/namespace}id"
            ]
            entity["title"] = entity_node.xpath(
                "./tei:placeName[1]/text()", namespaces=nsmap
            )[0]
            try:
                entity["geonames"] = entity_node.xpath(
                    './/tei:idno[@subtype="geonames"][1]/text()', namespaces=nsmap
                )[0]
            except IndexError:
                pass
            try:
                entity["gnd"] = entity_node.xpath(
                    './/tei:idno[@subtype="gnd"][1]/text()', namespaces=nsmap
                )[0]
            except IndexError:
                pass
            item["places"].append(entity)

        item["persons"] = []
        for entity_node in soc.any_xpath(".//tei:listPerson/tei:person"):
            entity = {}
            entity["id"] = entity_node.attrib[
                "{http://www.w3.org/XML/1998/namespace}id"
            ]
            entity_title = entity_node.xpath("./tei:persName[1]", namespaces=nsmap)[0]
            entity["title"] = " ".join(" ".join(entity_title.itertext()).split())
            try:
                entity["geonames"] = entity_node.xpath(
                    './/tei:idno[@subtype="geonames"][1]/text()', namespaces=nsmap
                )[0]
            except IndexError:
                pass
            try:
                entity["gnd"] = entity_node.xpath(
                    './/tei:idno[@subtype="gnd"][1]/text()', namespaces=nsmap
                )[0]
            except IndexError:
                pass
            item["persons"].append(entity)

        item["works"] = []
        item["fackel"] = []
        for entity_node in soc.any_xpath(".//tei:back/tei:listBibl/tei:bibl"):
            entity = {}
            entity["id"] = entity_node.attrib[
                "{http://www.w3.org/XML/1998/namespace}id"
            ]
            entity["title"] = entity_node.xpath(
                "./tei:title[1]/text()", namespaces=nsmap
            )[0]
            try:
                work_type = entity_node.attrib["type"]
                item["fackel"].append(entity)
            except KeyError:
                item["works"].append(entity)
        records.append(item)

try:
    client.collections[schema_name].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": schema_name,
    "enable_nested_fields": True,
    "fields": [
        {"name": "id", "type": "string"},
        {"name": "rec_id", "type": "string"},
        {"name": "title", "type": "string"},
        {"name": "full_text", "type": "string"},
        {"name": "case", "type": "object", "facet": True},
        {
            "name": "year",
            "type": "int32",
            "optional": True,
            "facet": True,
        },
        {"name": "persons", "type": "object[]", "facet": True, "optional": True},
        {"name": "places", "type": "object[]", "facet": True, "optional": True},
        {"name": "orgs", "type": "object[]", "facet": True, "optional": True},
        {"name": "works", "type": "object[]", "facet": True, "optional": True},
        {"name": "fackel", "type": "object[]", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)


make_index = client.collections[schema_name].documents.import_(records)
print(make_index)
print(f"done with indexing {schema_name}")
