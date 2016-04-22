#!/bin/bash

echo "creating album..."
mkdir -p thumbs
cat <<EOF > index.html
<html>
    <head>
    <style>
        body {
        width:500px;
        margin:auto;
        }
        img {
        margin:5px;
        }
    </style>
    </head>
    <body>
	<center><h1>Album title</h1></center>
	<p>
EOF

for img in *.jpg
do
    convert "$img" -resize "100x" "thumbs/$img"
    echo "<a href=\"$img\" ><img src=\"thumbs/$img\" title=\"$img\" /> \
	</a>" >> index.html
done

cat <<EOF >> index.html
	</p>
    </body>
</html>
EOF

exit 0
