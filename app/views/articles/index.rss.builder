xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0",  'xmlns:atom' => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Community @ Practicing Ruby"
    xml.description "Practicing Ruby's Community Site"
    xml.link "http://community.practicingruby.com"
    xml.send('atom:link', :href => articles_url(:format => :rss), :rel => "self", :type => "application/rss+xml")
    @articles.each do |article|
      xml.item do
        xml.title       article.title
        xml.description article.body
        xml.author      article.author_rss
        xml.pubDate     article.created_at.to_s(:rfc822)
        xml.link        article_url(article)
        xml.guid        article_url(article)
      end
    end
  end
end
