require 'rails_helper'

RSpec.describe 'Plot#index' do
  before :each do
    @g1 = Garden.create!(name: 'Urban Rooftop', organic: true)
    @g2 = Garden.create!(name: 'Where is the milk', organic: false)

    @p1 = @g1.plots.create!(number: 50, size: 'Large', direction: 'North')
    @p2 = @g1.plots.create!(number: 10, size: 'Small', direction: 'West')
    @p3 = @g1.plots.create!(number: 25, size: 'Medium', direction: 'East')


    visit plots_path
  end

  it "can list all plot numbers" do
    save_and_open_page
    expect(page).to have_content(@p1.number)
    expect(page).to have_content(@p2.number)
    expect(page).to have_content(@p3.number)

  end
end
