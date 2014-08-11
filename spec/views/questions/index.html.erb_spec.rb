require 'rails_helper'

RSpec.describe "questions/index", :type => :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :team => "Team",
        :position => "Position",
        :content => "MyText",
        :answer => "MyText",
        :difficulty => 1,
        :author_id => 2
      ),
      Question.create!(
        :team => "Team",
        :position => "Position",
        :content => "MyText",
        :answer => "MyText",
        :difficulty => 1,
        :author_id => 2
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Team".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
