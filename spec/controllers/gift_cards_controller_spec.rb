require 'rails_helper'
require 'faker'
require 'support/poltergeist_js_hack_for_login'
require 'capybara/email/rspec'
require 'capybara/poltergeist'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe GiftCardsController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # GiftCard. As you add validations to GiftCard, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      amount: '5.00',
      reason: 'signup',
      expiration_date: '05/20',
      proxy_id: '4321',
      batch_id: '4321',
      gift_card_number: '99998'
    }
  }

  let(:invalid_attributes) {
    {
      reason: '',
      amount: ''
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GiftCardsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  before do
    request.env['HTTP_REFERER'] = '/gift_cards' unless request&.env.nil?
  end

  describe 'GET #index' do
    it 'assigns all gift_cards as @gift_cards' do
      gift_card = GiftCard.create! valid_attributes
      get :index, {}
      expect(assigns(:gift_cards)).to eq([gift_card])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested gift_card as @gift_card' do
      gift_card = GiftCard.create! valid_attributes
      get :show, { id: gift_card.to_param }
      expect(assigns(:gift_card)).to eq(gift_card)
    end
  end

  describe 'GET #new' do
    it 'assigns a new gift_card as @gift_card' do
      get :new, {}
      expect(assigns(:gift_card)).to be_a_new(GiftCard)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested gift_card as @gift_card' do
      gift_card = GiftCard.create! valid_attributes
      get :edit, { id: gift_card.to_param }
      expect(assigns(:gift_card)).to eq(gift_card)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new GiftCard' do
        expect {
          post :create, { gift_card: valid_attributes }
        }.to change(GiftCard, :count).by(1)
      end

      it 'assigns a newly created gift_card as @gift_card' do
        post :create, { gift_card: valid_attributes }
        expect(assigns(:gift_card)).to be_a(GiftCard)
        expect(assigns(:gift_card)).to be_persisted
      end

      it 'redirects to the created gift_card' do
        post :create, { gift_card: valid_attributes }
        expect(response).to redirect_to(GiftCard.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved gift_card as @gift_card' do
        post :create, { gift_card: invalid_attributes }
        expect(assigns(:gift_card)).to be_a_new(GiftCard)
      end

      it "re-renders the 'new' template" do
        skip('unknown, routing issue')
        post :create, { gift_card: invalid_attributes }
        expect(response).to render_template('new')
      end

      it 'does not create a second signup giftcard' do
        skip('unknown, routing issue')
        post :create, { gift_card: valid_attributes }
        post :create, { gift_card: valid_attributes }
        expect(response).to render_template('new')
        expect(GiftCard.count).to eq(1)
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          {
            expiration_date: '05/20',
            proxy_id: '4321',
            batch_id: '4321',
            gift_card_number: '12345',
            reason: 'test',
            amount: '15.00'
          }
        }

        it 'updates the requested gift_card' do
          gift_card = GiftCard.create! valid_attributes
          put :update, { id: gift_card.to_param, gift_card: new_attributes }
          gift_card.reload
          expect(gift_card.amount).to have_content '15.00'
        end

        it 'assigns the requested gift_card as @gift_card' do
          gift_card = GiftCard.create! valid_attributes
          put :update, { id: gift_card.to_param, gift_card: valid_attributes }
          expect(assigns(:gift_card)).to eq(gift_card)
        end

        it 'redirects to the gift_card' do
          gift_card = GiftCard.create! valid_attributes
          put :update, { id: gift_card.to_param, gift_card: valid_attributes }
          expect(response).to redirect_to(gift_card)
        end
      end

      context 'with invalid params' do
        it 'assigns the gift_card as @gift_card' do
          gift_card = GiftCard.create! valid_attributes
          put :update, { id: gift_card.to_param, gift_card: invalid_attributes }
          expect(assigns(:gift_card)).to eq(gift_card)
        end

        it "re-renders the 'edit' template" do
          gift_card = GiftCard.create! valid_attributes
          put :update, { id: gift_card.to_param, gift_card: invalid_attributes }
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested gift_card' do
        gift_card = GiftCard.create! valid_attributes
        expect {
          delete :destroy, { id: gift_card.to_param }
        }.to change(GiftCard, :count).by(-1)
      end

      it 'redirects to the gift_cards list' do
        gift_card = GiftCard.create! valid_attributes
        delete :destroy, { id: gift_card.to_param }
        expect(response).to redirect_to(gift_cards_url)
      end
    end
  end
end
