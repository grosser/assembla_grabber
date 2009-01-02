class AssemblaGrabber
  ASSEMBLA = "http://www.assembla.com"
  LOGIN_URL = 'https://www.assembla.com/user/do_login'
  EDIT_LINK = 'Edit this page'

  def initialize(config_path)
    @config = YAML.load(IO.read(config_path))
    @config['root'].sub!(%r[/$],'')#remove trailing slash from root url
  end

  def grab_all
    wiki_links = agent.get(to_url(root)).links.select {|link| link.uri.to_s.include?(root)}
    wiki_links.each do |link|
      begin
        page = find_or_build_by_name(link.uri.to_s.sub(root+'/',''))
        next unless page.new_record?
        page.attributes = {
          :human_name=>link.text,
          :text=>grab_page(link.uri.to_s)
        }
        page.save!
      rescue
        puts link.uri.to_s
        puts $!
      end
      sleep 1
    end
  end

  def grab_page(page)
    puts page = page.sub(%r[/show/],'/edit/')
    page = agent.get(to_url(page))
    Hpricot(page.body).search("#wiki-editor").inner_html
  end

private

  def find_or_build_by_name(name)
    Page.find_by_name(name) || Page.new(:name=>name)
  end

  def to_url(path)
    ASSEMBLA + path
  end

  def root
    @config['root']
  end

  def agent
    return @agent if @agent
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = WWW::Mechanize::AGENT_ALIASES.keys.rand
    @agent.post(LOGIN_URL,{'user[login]'=>@config['login'],'user[password]'=>@config['password']})#login
    @agent
  end
end