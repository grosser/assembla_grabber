# This script posts all grabbed pages to a trac server
# Go to the track server and enter your cookie data here
# use webdeveloper toolbar to get your cookie info
require 'init'

def add_cookie(agent)
  fakeuri = Struct.new(:host)
  c = WWW::Mechanize::Cookie.new('trac_auth','COOKIE VALUE FROM BROWSER')
  c.domain = 'TRAC HOST'
  c.path = 'COOKIE PATH'
  c.secure = false
  c.expires = Time.now + 10.years
  c.version = 0
  agent.cookie_jar.add(fakeuri.new(c.domain), c)
end

def post_contents
  agent = WWW::Mechanize.new
  add_cookie(agent)
  agent.get(ROOT) #test

  Page.all.each do |page|
    webpage = agent.get(ROOT+page.name+EDIT)
    next if page.text.blank?
    begin
      puts "Writing #{page.name}"
      form = webpage.forms[1]
      form.field('text').value = page.text
      form.click_button(form.buttons[1])
    rescue
      puts $!
      puts "Not modified -> 500"
    end
  end

end

def write_new_links
  File.open 'new_links','w' do |f|
    f.puts Page.all.map {|page| "[wiki:#{page.name} #{page.human_name}]"} * "\n\n"
  end
end

ROOT = "http://HOST/PATH TO WIKI ROOT"
EDIT = "?action=edit"

#post_contents
#write_new_links