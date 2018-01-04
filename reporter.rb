require 'json'
require_relative 'features/support/api_helper.rb'

report_file=File.read('report.json')

report_hash= JSON.parse(report_file)
# puts report_hash.first['elements'].first['after'].last['result']['status']
# ['after']['result']['status']
report_hash.each do |i|
  # puts i['elements'].first['before'].first['result']['status']
  # i['elements'].first['steps'].each do |e|
  #   puts e['result']['status']
  # end
  # puts i['elements'].first['after'].first['result']['status']
end












# build_name=ARGV[0]
# build_number=ARGV[1]
# job_url=ARGV[2]
#
# thumbnail={'url'=>'https://vignette.wikia.nocookie.net/herebemonsters/images/3/3b/Cucumber-Sprite.png/revision/latest?cb=20140326235503'}
# fields=[]
# embed=[]
# fields.push({'name'=>'Build name','value'=>build_name.to_s})
# fields.push({'name'=>'Build number','value'=>build_number.to_s})
# fields.push({'name'=>'Link to report','value'=>job_url.to_s})
# embed.push({'title'=>'Kursa darbs',
#             'color'=>4441141,
#             'thumbnail'=>thumbnail,
#             'fields'=>fields})
#
#
# payload={'content'=>'Automatic message','embeds'=>embed}.to_json
#
# post('https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1',
#      headers: {'Content-Type'=>'application/json'},
#      cookies: {},
#      payload: payload)