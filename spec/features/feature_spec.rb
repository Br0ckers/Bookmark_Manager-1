require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('Makers', 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('Destroy', 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('Google', 'http://www.google.com');")

    visit('/bookmarks')
    expect(page).to have_link('Makers', href: "http://www.makersacademy.com")
    expect(page).to have_link('Destroy', href: "http://www.destroyallsoftware.com")
    expect(page).to have_link('Google', href: "http://www.google.com")
  end
end

feature 'Adding bookmarks' do
  scenario 'A user can add bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit('/')
    click_button('See bookmarks')
    click_button('add bookmark')
    fill_in('URL', :with => 'http://www.bbc.co.uk')
    fill_in('TITLE', :with => 'BBC')
    click_button('Add')
    expect(page).to have_link('BBC', href: "http://www.bbc.co.uk")
  end

end
