str1="$( grep -w 'version:' Chart.yaml | grep -v 'version: \"*\"')"
minorVS="${str1##*.}"
echo Current version $str1
minorVS=$((minorVS+1))
str2="${str1%.*}.$minorVS"
echo Update to version $str2
sed -i "/\"/!s/version:.*/$str2/g" Chart.yaml

str3="$(grep -w 'appVersion:' Chart.yaml)"
echo Current appVersion $str3
# minorVS="${str3##*.}"
# minorVS="${minorVS%?}"
# minorVS=$((minorVS+1))
str4="${POM_VERSION}-${COMMIT}"
echo Update to appVersion $str4
sed -i "s/appVersion:.*/appVersion: \"$str4\"/g" Chart.yaml
