atom_feed(url: articles_url(format: :atom)) do |feed|
  feed.title    "Community @ Practicing Ruby"
  feed.subtitle "Practicing Ruby's Community Site"
  feed.updated  @articles.first.created_at

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title     article.title
      entry.content   article.body, type: 'html'

      entry.author do |author|
        author.name   article.author.name
        author.email  article.author.email
      end
    end
  end
end
