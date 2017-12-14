require 'spec_helper'

RSpec.describe "Stories" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves stories' do
    stories = uatu.stories

    expect(stories.size).to eq 7
    expect(stories.first.title).to eq "Interior #1208"
  end

  it 'retrieves a single story' do
    story = uatu.story(13245)
    expect(story.title).to eq "Fantastic Forum"
  end

end
