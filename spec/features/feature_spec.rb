require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

    visit('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
  end
end

feature 'Adding bookmarks' do
  scenario 'A user can add bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    visit('/')
    click_button('See bookmarks')
    click_button('add bookmark')
    fill_in('URL', :with => 'http://www.bbc.co.uk')
    click_button('Add')
    expect(page).to have_content "http://www.bbc.co.uk"
  end

end


