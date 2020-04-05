
require 'twitter' #twitterの読み込み
require 'nokogiri'
require 'open-uri'

#作成したTwitterアプリにアクセスする情報を記載する
twClient = Twitter::REST::Client.new do |config|
    config.consumer_key    = "UdyiNoMLT8hUaTpATs1L1ued5"
    config.consumer_secret = "ldtObxVx7v8TQ0PXURjTfpblHsiOXAYw2Htbp4nAY26izf3UNy"
    config.access_token    = "704298046255816704-bNRATUk0oDwj31C1uC5vQ06oOAUlD6K"
	config.access_token_secret = "dZBtjEotiMma7u88TYxCne9fGcmGa4foKU11Y5LOt0H9s"
	#   CONSUMER_KEY = 'UdyiNoMLT8hUaTpATs1L1ued5'
#   CONSUMER_SECRET = 'ldtObxVx7v8TQ0PXURjTfpblHsiOXAYw2Htbp4nAY26izf3UNy'
#   OAUTH_TOKEN = '704298046255816704-bNRATUk0oDwj31C1uC5vQ06oOAUlD6K'
#   OAUTH_TOKEN_SECRET = 'dZBtjEotiMma7u88TYxCne9fGcmGa4foKU11Y5LOt0H9s'
end

# while 1 do
# twClient.update Time.now#ツイートする文字列
# puts Time.now
# sleep 100
# end
url = "https://www.pref.fukuoka.lg.jp/contents/covid19-hassei.html"

charset = nil
previous =nil

while 1 do
html = open(url) do |f|
    charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

if doc.css('#main_content > div.detail_free > p:nth-child(3) > a').text != previous
  kanja = doc.css('#main_content > div.detail_free > p:nth-child(3) > a').text
  detail =  doc.xpath('//*[@id="main_content"]/div[1]/p[3]/text()')

	# kanja = kanja.delete("）").match(/患者(.*)/m).to_s
	# kanja = kanja.delete("患者").split("～")
	# kanja = kanja.tr("０-９", "0-9")
	# puts kanja
	tweet = "【コロナウイルス最新情報bot】\n#{kanja}\n#{detail}"

	twClient.update tweet
#main_content > div.detail_free > p:nth-child(3) > a
end

previous = doc.css('#main_content > div.detail_free > p:nth-child(3) > a').text
sleep 10
end
# puts doc.xpath('//*[@id="main_content"]/div[1]/h3[1]').text
# puts doc.css('#main_content > div.detail_free > p:nth-child(4) > a').each do |element|
# puts element.text
# end