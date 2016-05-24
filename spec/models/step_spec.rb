# == Schema Information
#
# Table name: steps
#
#  id             :integer          not null, primary key
#  display_order  :integer
#  title          :string
#  description    :text
#  steppable_id   :integer
#  steppable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

describe Step do

  it { is_expected.to validate_presence_of(:description) }
  # it { is_expected.to validate_length_of(:description).is_at_most(1024)}
  it { is_expected.to belong_to(:steppable) }

  context 'with multiple steps associated to a recipe' do

    let(:sequential_recipe) { FactoryGirl.create(:recipe, :with_sequential_steps)}
    let(:standard_recipe) {
      FactoryGirl.create(:recipe, steps:
        [
          FactoryGirl.create(:step, description: 'Alpha'),
          FactoryGirl.create(:step, description: 'Gamma'),
          FactoryGirl.create(:step, description: 'Beta')
        ]
      )
    }

    it 'orders by ID if no display order is specified' do
      expect(standard_recipe.steps.first.description).to eq 'Alpha'
      expect(standard_recipe.steps.second.description).to eq 'Gamma'
      expect(standard_recipe.steps.last.description).to eq 'Beta'
    end

    it 'orders by display order if specified' do
      expect(sequential_recipe.steps.first.display_order).to eq 1
      expect(sequential_recipe.steps.second.display_order).to eq 2
      expect(sequential_recipe.steps.third.display_order).to eq 3
      expect(sequential_recipe.steps.fourth.display_order).to eq 4
      expect(sequential_recipe.steps.fifth.display_order).to eq 5
      expect(sequential_recipe.steps.last.display_order).to eq 6
    end
  end
end
