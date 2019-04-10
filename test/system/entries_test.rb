require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "index shows all entries" do
    visit entries_path
    assert_css 'div.entry', count: 3
  end
  test 'search for text finds title' do
    visit entries_search_path(content_search: 'The Absurdity of Sexual identity')
    assert_css'div.entry', count: 1
  end
  test 'search for text finds description' do
    visit entries_search_path(content_search: 'Socialist realism and Debordist situation ')
    assert_css'div.entry', count: 1
  end
  test 'search for text finds content' do
    visit entries_search_path(content_search: 'Lyotard')
    assert_css'div.entry', count: 2
  end
  test 'search on included tags' do
    visit entries_search_path params: { tag_search: 'drowning' }
    assert_css'div.entry', count: 2
  end
  test 'search on excluded tags' do
    visit entries_search_path params: { tag_search: '-sailing' }
    assert_css'div.entry', count: 1
  end
  test 'create' do
    login_user
    visit new_entry_path
    page.fill_in 'Title', with: 'Create Test Title'
    page.fill_in 'Description', with: 'Create Test Description'
    page.fill_in 'Notes', with: 'Create Test Notes'
    page.fill_in 'Content', with: 'Create Test Content'
    click_on 'Create Entry'
    assert page.has_content? 'Create Test Title'
    assert page.has_content? 'Create Test Description'
    assert page.has_content? 'Create Test Notes'
    assert page.has_content? 'Create Test Content'
  end
  test 'edit' do
    login_user
    visit edit_entry_path entries(:entry_one).id
    page.fill_in 'Title', with: 'Edited Test Title'
    page.fill_in 'Description', with: 'Edited Test Description'
    page.fill_in 'Notes', with: 'Edited Test Notes'
    page.fill_in 'Content', with: 'Edited Test Content'
    click_on 'Update Entry'
    assert page.has_content? 'Edited Test Title'
    assert page.has_content? 'Edited Test Description'
    # assert page.has_content? 'Edited Test Notes'
    assert page.has_content? 'Edited Test Content'
  end
  test 'delete' do
    login_user
    visit entries_path
    assert page.has_content? 'The Absurdity of Sexual identity'
    visit entry_path entries(:entry_one).id
    click_on 'Destroy'
    page.accept_alert
    assert_not page.has_content? 'The Absurdity of Sexual identity'
  end
end
