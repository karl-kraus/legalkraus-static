import glob
from tqdm import tqdm
from acdh_tei_pyutils.tei import TeiReader

files = sorted(glob.glob('./data/*/*.xml'))

for x in tqdm(files, total=len(files)):
    try:
        doc = TeiReader(x)
    except:
        continue
    for bad in doc.any_xpath('.//tei:back//tei:noteGrp'):
        bad.getparent().remove(bad)
    doc.tree_to_file(x)