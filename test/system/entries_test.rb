require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  test "index shows all entries" do
    visit entries_path
    assert_equal 3, page.all('div.entry').length
  end
  test 'search for text finds title' do
    visit entries_search_path(content_search: 'The Absurdity of Sexual identity')
    assert_equal 1, page.all('div.entry').length
  end
  test 'search for text finds description' do
    visit entries_search_path(content_search: 'Socialist realism and Debordist situation ')
    assert_equal 1, page.all('div.entry').length
  end
  test 'search for text finds content' do
    visit entries_search_path(content_search: 'Lyotard')
    assert_equal 2, page.all('div.entry').length
  end
  test 'search on included tags' do
    visit entries_search_path params: { tag_search: 'drowning' }
    assert_equal 2, page.all('div.entry').length
  end
  test 'search on excluded tags' do
    visit entries_search_path params: { tag_search: '-sailing' }
    assert_equal 1, page.all('div.entry').length
  end
end
