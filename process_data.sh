echo "add xml:id, prev and next attributes"
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"
add-attributes -g "./data/indices/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"
add-attributes -g "./data/cases_tei/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"
add-attributes -g "./data/handapparat/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"
add-attributes -g "./data/topics/*.xml" -b "https://id.acdh.oeaw.ac.at/legalkraus"

echo "denormalize indices in objects"
denormalize-indices -f "./data/editions/D_*.xml" -i "./data/indices/*.xml" -m ".//@*[contains(., '#pmb') or contains(., '#lk_fackel__') or contains(., '#legal-')]" -x ".//tei:titleStmt/tei:title[1]/text()" -b pmb11988

echo "remove listevents in back elements"
python rm_listevent.py

# echo "write mentions into listlegal.xml"
# python listlegal.py

echo "create cases-json"
python create_case_index.py

echo "create up statit oai-pmh files"
python oai-pmh/make_files.py
