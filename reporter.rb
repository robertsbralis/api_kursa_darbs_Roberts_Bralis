require 'json'
require_relative 'features/support/api_helper.rb'

report_file=File.read('report.json')

report_hash= JSON.parse(report_file)
step_win=0
step_lose=0
scenario_win=0
scenario_lose=0
scenario_count=0
report_hash.each do |i|
  scenario_count=i['elements'].count
  i['elements'].each do |scenario|
    (scenario['before'] + scenario['steps'] + scenario['after']).each do |step|
      status = step['result']['status']
      status=='passed' ? step_win+=1 : step_lose+=1
    end
    if (step_lose)>1
        scenario_lose+=1
    else
      scenario_win+=1
    end
end
end
win_ratio=sprintf('%.2f', ((scenario_win/scenario_count).to_f)*100.to_f)
lose_ratio=sprintf('%.2f',((scenario_lose/scenario_count).to_f)*100.to_f)

job_name=ARGV[0]
build_number=ARGV[1]


job_url='http://jenkinsautomation.tdlbox.com/job/Kursa_darbs_Roberts_Bralis/job/'+job_name+'/'+build_number+'/cucumber-html-reports/overview-features.html'



thumbnail={'url'=>'https://www.testingexcellence.com/wp-content/uploads/2017/02/cucumber_pairwise_testing.png'}
fields=[]
embed=[]
fields.push({'name'=>'Build name','value'=>job_name.to_s})
fields.push({'name'=>'Build number','value'=>build_number.to_s})
fields.push({'name'=>'Link to report','value'=>job_url.to_s})
fields.push({'name'=>'Passed tests','value'=>scenario_win.to_s})
fields.push({'name'=>'Failed tests','value'=>scenario_lose.to_s})
fields.push({'name'=>'Passed tests ratio','value'=>win_ratio.to_s+' %'})
fields.push({'name'=>'Failed tests ratio','value'=>lose_ratio.to_s+' %'})
embed.push({'title'=>'Kursa darbs',
                'color'=>4441141,
                'thumbnail'=>thumbnail,
                'fields'=>fields})


payload={'content'=>'Automatic message(Kursa darbs)','embeds'=>embed}.to_json

post('https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1',
     headers: {'Content-Type'=>'application/json'},
     cookies: {},
     payload: payload)
