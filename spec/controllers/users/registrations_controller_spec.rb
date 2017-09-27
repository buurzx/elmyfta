# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    let!(:user) { build(:user, email: 'tt@test.tt') }
    let!(:org) { create(:organization) }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when create user and organization' do
      it 'creates user' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                              org_name: 'Vasya') }
        end.to change(User, :count).by 1
      end

      it 'creates user with password' do
        post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                            org_name: 'Vasya') }
        expect(User.last.encrypted_password.blank?).to be_falsey
      end

      it 'creates organization if it\'s not exists' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                              org_name: 'Vasya') }
        end.to change(Organization, :count).by 1
      end

      it 'creates organization if it\'s not exists and mark as contact' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                              org_name: 'Vasya') }
        end.to change(User, :count).by 1
        expect(User.last.reload.contact).to be true
      end

      it 'organization should has requisites' do
        post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                            org_name: 'Vasya') }
        org = Organization.find_by(inn: '1231231231')
        expect(org).not_to be_nil
        expect(org.name).to eq 'Vasya'
        expect(org.contact).to eq user.name
      end

      it 'should create user if organization exist' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: org.inn,
                                                              org_name: org.name) }
        end.to change(User, :count).by 1
      end

      it 'should send email with password' do
        expect(WelcomeMailer).to receive_message_chain(:welcome_email, :deliver_later)
        post :create, params: { user: user.attributes.merge(inn: '1231231231',
                                                            org_name: 'Vasya') }
      end
    end

    context 'when create user and organization with errors' do
      it 'should not create organization with invalid inn' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: '31231231',
                                                              org_name: 'Vasya') }
        end.not_to change(Organization, :count)
      end

      it 'should not create user if organization exist and name wrong' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: org.inn,
                                                              org_name: 'Wrong') }
        end.not_to change(User, :count)
      end

      it 'should not organization user if organization exist and name wrong' do
        expect do
          post :create, params: { user: user.attributes.merge(inn: org.inn,
                                                              org_name: 'Wrong') }
        end.not_to change(Organization, :count)
      end
    end

    context 'when create user form products new' do
      let!(:org) { build(:organization) }

      it 'creates user' do
        expect do
          post :create, params: { user: org.attributes.merge(inn: '1231231231',
                                                             org_name: 'Vasya',
                                                             phone: '79999999999',
                                                             address: 'Zarya, 77-12',
                                                             city: 'Moscow',
                                                             contact: 'Vasya',
                                                             email: 'qwe@wew.we',
                                                             site: 'reeq.re') }
        end.to change(User, :count).by 1
      end

      it 'creates user' do
        post :create, params: { user: org.attributes.merge(inn: '12312231',
                                                           org_name: 'Vasya',
                                                           phone: '79999999999',
                                                           address: 'Zarya, 77-12',
                                                           city: 'Moscow',
                                                           contact: 'Vasya',
                                                           email: 'qwe@wew.we',
                                                           site: 'reeq.re') }
        expect(response.status).to eq 422
      end
    end
  end
end
