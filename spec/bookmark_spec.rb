require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.destroyallsoftware.com', 'Destroy');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'Google');")

      bookmarks = Bookmark.all

      expect(bookmarks).to include({ title: 'Makers', url: "http://www.makersacademy.com" })
      expect(bookmarks).to include({ title: 'Destroy', url: "http://www.destroyallsoftware.com" })
      expect(bookmarks).to include({ title: 'Google', url: "http://www.google.com" })
    end
  end
  describe '.add' do
    it 'adds bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      Bookmark.add('BBC', 'http://www.bbc.co.uk')

      bookmarks = Bookmark.all
      expect(bookmarks).to include({ title: 'BBC', url: "http://www.bbc.co.uk" })
    end
  end
end
