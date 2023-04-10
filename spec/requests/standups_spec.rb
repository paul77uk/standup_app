require 'rails_helper'

RSpec.describe "/standups", type: :request do
  login_admin

  let(:valid_attributes) do
    {
      user_id: @admin.id,
      standup_date: Date.today.iso8601,
      todos_attributes: [
        { title: 'YE Old Thingy', "_destroy": 'false' }
      ]
    }
  end

  let(:invalid_attributes) do
    { user_id: nil, standup_date: Date.today.iso8601, todos_attributes: [] }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns a new standup as @standup' do
      get standups_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #new' do
    it 'redirects without a date' do
      get new_standup_path, params: {}
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #new' do
    it 'assigns a new standup as @standup' do
      get new_standup_path, params: { date: Date.today.iso8601 }
      expect(assigns(:standup)).to be_a_new(Standup)
    end
  end

  describe 'GET #new redirect to edit on existance' do
    it 'it redirects' do
      standup = FactoryBot.create(:standup, valid_attributes)
      get new_standup_path, params: { date: standup.standup_date }
      expect(response).to redirect_to(edit_standup_path(date: standup.standup_date))
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested standup as @standup' do
      standup = FactoryBot.create(:standup, valid_attributes)
      get edit_standup_path(standup), params: { date: standup.standup_date }
      expect(assigns(:standup)).to eq(standup)
    end
  end

  describe 'GET #edit redirect to new on non-existance' do
    it 'it redirects' do
      date = Date.today.iso8601
      get edit_standup_path(), params: { date: date }
      expect(response).to redirect_to("/s/new/#{date}")
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Standup' do
        expect do
          post(
            standups_path,
            params: { standup: valid_attributes }
          )
        end.to change(Standup, :count).by(1)
      end

      it 'assigns a newly created standup as @standup' do
        post(
          standups_path,
          params: { standup: valid_attributes }
        )
        expect(assigns(:standup)).to be_a(Standup)
        expect(assigns(:standup)).to be_persisted
      end

      it 'redirects to the created standup' do
        post(
          standups_path,
          params: { standup: valid_attributes }
        )
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { standup_date: Date.tomorrow.iso8601 }
      end

      it 'updates the requested standup' do
        @standup = FactoryBot.create(:standup, valid_attributes)
        put(
          standup_path(@standup),
          params: { id: @standup.to_param, standup: new_attributes }
        )
        @standup.reload
        expect(@standup.updated_at).to be > @standup.created_at
      end

      it 'assigns the requested standup as @standup' do
        standup = FactoryBot.create(:standup, valid_attributes)
        put(
          standup_path(standup),
          params: { id: standup.to_param, standup: valid_attributes }
        )
        expect(assigns(:standup)).to eq(standup)
      end

      it 'redirects to the standup' do
        standup = FactoryBot.create(:standup, valid_attributes)
        put(
          standup_path(standup),
          params: { id: standup.to_param, standup: valid_attributes }
        )
        expect(response).to redirect_to(root_path)
      end
    end
  end
end