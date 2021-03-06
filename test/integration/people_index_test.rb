require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = people(:john)
    @non_admin = people(:jane)
  end

 test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get people_path
    assert_template 'people/index'
    assert_select 'div.pagination'
    # Assert that pagination div exists.
    first_page_of_people = Person.paginate(page: 1)
    first_page_of_people.each do |person|
      assert_select 'a[href=?]', person_path(person), text: person.name
      unless person == @admin
        assert_select 'a[href=?]', person_path(person), text: 'delete'
        # Admin should not have 'delete' next to his name.
      end
    end
    assert_difference 'Person.count', -1 do
      delete person_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get people_path
    assert_select 'a', text: 'delete', count: 0
  end
  
end
