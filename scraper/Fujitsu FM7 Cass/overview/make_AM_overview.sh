# this script will generate individual Attract Mode overview files
# using an Emulation Station gamelist.xml file
# 
# The <path> line in the gamelist.xml file is expected to be 
# 
# <path>./romfilename.ext</path>
#
# You may have to perform a Find/Replace within the gamelist.xml file for 
# the <path> line to make it work.
#

cat gamelist.xml |grep -v "xml version" |grep -v "<game" |grep -v "<game id" |grep -v "<name" |grep -v "<publi" |grep -v "<devel" |grep -v "<image" |grep -v "<marque" |grep -v "<video" |grep -v "<release" |grep -v "<genre" |grep -v "<player" |grep -v "<thumbnail" |grep -v "<rating" |grep -v "<playcount" |grep -v "<lastplay" |grep -v "<develo" |grep -v "</develop" |grep -v "</publisher" |grep -v "</game" > source.xml

while read line
do
if [[ $line == *"<game id="* ]]; then
  echo $line >> temp.xml
elif [[ $line == *"<path"* ]]; then
  fname=`echo $line |cut -f2 -d "/" |cut -f1 -d "<" | rev | cut -f 2- -d '.' | rev`
elif [[ $line == *"<desc"* ]]; then
  echo "${line}" > "${fname}.txt"
else
  echo "$line" >> "${fname}.txt"
fi
done < source.xml

perl -pi -w -e 's/\<desc\>//g;' *.txt
perl -pi -w -e 's/\<\/desc\>//g;' *.txt
perl -pi -w -e 's/\<desc\/\>//g;' *.txt
