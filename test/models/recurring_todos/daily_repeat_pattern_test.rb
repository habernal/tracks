require_relative '../../test_helper'

module RecurringTodos

  class DailyRepeatPatternTest < ActiveSupport::TestCase
    fixtures :users

    def setup
      @admin = users(:admin_user)
    end

    def test_daily_attributes
      rt = @admin.recurring_todos.first

      assert_equal rt.every_other1, rt.pattern.every_x_days
      assert_equal rt.only_work_days, rt.pattern.only_work_days?
    end

    def test_validate
      rt = @admin.recurring_todos.first
      assert rt.valid?, "rt should be valid at start"

      rt.every_other1 = nil
      rt.only_work_days = false
      assert !rt.valid?, "every_x_days should not be empty then only_work_days==false"

      rt.only_work_days = true
      assert rt.valid?, "every_x_days may have any value for only_work_days==true"

      rt.only_work_days = false
      rt.every_other1 = 2
      assert rt.valid?, "should be valid again"
    end

  end

end