require 'rails_helper'

RSpec.describe "questions/show", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :team => "Team",
      :position => "Position",
      :content => "MyText",
      :answer => "MyText",
      :difficulty => 1,
      :author_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Team/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
