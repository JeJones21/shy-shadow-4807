require 'rails_helper'

RSpec.describe 'Plot#index' do
  before :each do
    @g1 = Garden.create!(name: 'Urban Rooftop', organic: true)
    @g2 = Garden.create!(name: 'Where is the milk', organic: false)

    @p1 = @g1.plots.create!(number: 50, size: 'Large', direction: 'North')
    @p2 = @g1.plots.create!(number: 10, size: 'Small', direction: 'West')
    @p3 = @g1.plots.create!(number: 25, size: 'Medium', direction: 'East')

    @plant1 = @p1.plants.create!(name: 'Prickly Pear Cactus', description: 'Spikey', days_to_harvest: 100)
    @plant2 = @p2.plants.create!(name: 'Monstera', description: 'Swiss Cheese', days_to_harvest: 45)
    @plant3 = @p3.plants.create!(name: 'Aloe', description: 'Medicinal', days_to_harvest: 60)
    @inventory1 = Inventory.create!(plant_id: @plant1.id, plot_id: @p1.id)
    @inventory1 = Inventory.create!(plant_id: @plant2.id, plot_id: @p1.id)
    @inventory1 = Inventory.create!(plant_id: @plant3.id, plot_id: @p1.id)
    @inventory1 = Inventory.create!(plant_id: @plant3.id, plot_id: @p2.id)

    visit plots_path
  end

  it "can list all plot numbers" do

    expect(page).to have_content(@p1.number)
    expect(page).to have_content(@p2.number)
    expect(page).to have_content(@p3.number)
  end

  it "can list all plants related to plot" do

    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)
  end

  it "can show a link to remove a plant from plot" do
    expect(page).to have_link("Remove Plant #{@plant1.name}")

    click_link "Remove Plant #{@plant1.name}"
    save_and_open_page

    expect(page).to_not have_content(@plant1.name)
  end
end
