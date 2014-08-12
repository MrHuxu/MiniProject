require 'rails_helper'

RSpec.describe "questions/new", :type => :view do
  before(:each) do
    assign(:question, Question.new(
      :team => "MyString",
      :position => "MyString",
      :content => "MyText",
      :answer => "MyText",
      :difficulty => 1,
      :author_id => 1
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_team[name=?]", "question[team]"

      assert_select "input#question_position[name=?]", "question[position]"

      assert_select "textarea#question_content[name=?]", "question[content]"

      assert_select "textarea#question_answer[name=?]", "question[answer]"

      assert_select "input#question_difficulty[name=?]", "question[difficulty]"

      assert_select "input#question_author_id[name=?]", "question[author_id]"
    end
  end
end
