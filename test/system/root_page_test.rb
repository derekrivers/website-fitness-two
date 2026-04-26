# frozen_string_literal: true

require 'application_system_test_case'

class RootPageTest < ApplicationSystemTestCase
  test 'root page renders all section headings' do
    visit root_path

    [
      'Fitness that fits real life in Scotland',
      'Personal Training',
      'Group Classes',
      'Nutrition Coaching',
      'Training Videos',
      'Client Results',
      'Book Your FitnessFormula Session'
    ].each do |heading|
      assert_selector 'h1,h2', text: heading
    end
  end
end
