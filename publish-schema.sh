REGISTRY_URL="${REGISTRY_URL:-http://localhost:8000}"
DOMAIN="${DOMAIN:-example}"
SCHEMA="${SCHEMA:-Measurement}"
VERSION="${VERSION:-1.0.2-SNAPSHOT}"
FILE="${FILE:=./src/main/resources/schema-history/1.0.2-SNAPSHOT.csv}"
DEFINITION=$(cut -f 2 -d "|" $FILE)

echo "> ${SCHEMA}-${VERSION}"
echo $DEFINITION

curl -X POST "${REGISTRY_URL}/apis/registry/v2/groups/${DOMAIN}/artifacts?ifExists=UPDATE" \
-H 'Content-Type: application/json; artifactType=AVRO' \
-H "X-Registry-ArtifactId: ${SCHEMA}" \
-H "X-Registry-Version: ${VERSION}" \
-H 'X-Registry-ArtifactType: AVRO' \
--data "${DEFINITION}"

echo "\n---\n"

curl "${REGISTRY_URL}/apis/registry/v2/groups/${DOMAIN}/artifacts/${SCHEMA}/versions/${VERSION}"
