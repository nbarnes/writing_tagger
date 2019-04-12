
class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "require logged in user to access new entry form" do 
    get new_entry_path
    assert_redirected_to entries_path
  end
  test "require logged in user to create entry" do
    post '/entries', params: { entry: { content: 'rawr rawr rawr', title: 'the fiercest fox'}}
    assert_response :unauthorized
  end
  test "require logged in user to own entry in order to edit" do
    patch "/entries/#{Entry.first.id}", params: { entry: { content: 'rawr rawr rawr', title: 'the fiercest fox'}}
    assert_response :unauthorized
  end
  test "require logged in user to own entry in order to delete" do
     delete "/entries/#{Entry.first.id}"
     assert_response :unauthorized
  end
end