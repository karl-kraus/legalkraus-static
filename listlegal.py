import glob
from collections import defaultdict, OrderedDict
from lxml import etree as ET
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm

LIST_LEGAL = "./data/indices/listlegal.xml"

legal_doc = TeiReader(LIST_LEGAL)

files = glob.glob('./data/editions/D_*.xml')
refs = defaultdict(set)
for x in tqdm(files, total=len(files)):
    try:
        doc = TeiReader(x)
    except:
        continue
    xml_id = x.split('/')[-1]
    for ref in doc.any_xpath('.//tei:rs[@type="law"]/@ref'):
        title = " ".join(doc.any_xpath('.//tei:title')[0].text.split())
        refs[ref].add(f"{title}|{xml_id}")

ref_lookup = OrderedDict(sorted(refs.items()))
for x in legal_doc.any_xpath('.//tei:bibl'):
    corresp = x.attrib['corresp']
    try:
        match = ref_lookup[corresp]
    except:
        continue
    for y in match:
        ref = ET.Element("{http://www.tei-c.org/ns/1.0}ref")
        ref.attrib['target'] = y.split('|')[1]
        ref.text = f"{y.split('|')[0]}"
        x.append(ref)

legal_doc.tree_to_file(LIST_LEGAL)