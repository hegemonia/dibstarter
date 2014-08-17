# curl https://api.scalablepress.com/v2/design \
# -u :2ceaad81c00f173eaf11fc2412216885 \
#   -F "type=dtg" \
#   -F "sides[front][artwork]=@/Users/Thoughtworks/Downloads/EliseSari.png" \
#   -F "sides[front][colors][0]=white" \
#   -F "sides[front][dimensions][width]=5"

# curl --trace out.txt https://api.scalablepress.com/v2/quote \
#   -u :2ceaad81c00f173eaf11fc2412216885 \
#   -d "type=dtg" \
#   -d "sides[front]=1" \
#   -d "products[0][id]=gildan-sweatshirt-crew" \
#   -d "products[0][color]=ash" \
#   -d "products[0][quantity]=12" \
#   -d "products[0][size]=lrg" \
#   -d "address[name]=Jordan Scheller" \
#   -d "address[address1]=805 East Strain Street" \
#   -d "address[city]=Fort Branch" \
#   -d "address[state]=IN" \
#   -d "address[zip]=47648" \
#   -d "address[country]=US" \
#   -d "designId=53efb04107266f691c313c85"

curl --trace out.txt https://api.scalablepress.com/v2/quote \
  -u :2ceaad81c00f173eaf11fc2412216885 \
  -d "type=dtg" \
  -d "sides[front]=1" \
  -d "products[0][id]=gildan-sweatshirt-crew" \
  -d "products[0][color]=ash" \
  -d "products[0][quantity]=12" \
  -d "products[0][size]=lrg" \
  -d "address[name]=Thomas Wu" \
  -d "address[address1]=1836 McFarlane St" \
  -d "address[city]=San Marino" \
  -d "address[state]=CA" \
  -d "address[zip]=91108" \
  -d "address[country]=US" \
  -d "designId=53efb04107266f691c313c85"