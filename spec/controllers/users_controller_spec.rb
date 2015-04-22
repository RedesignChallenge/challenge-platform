require 'rails_helper'

describe UsersController do

  describe "GET #show" do

    let(:user) {
      FactoryGirl.create(:user)
    }

    it 'finds the user with the specified id' do
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end

    it 'renders the view' do
      get :show, id: user.id
      expect(response).to render_template :show
    end
  end
end