# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    render_views

    let!(:org) { create(:organization) }
    let!(:org_params) { { inn: '1231231231', name: 'Example', city: 'Moscow' } }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when invalid params' do
      let(:org) { create(:organization, inn: org_params[:inn]) }

      it 'not creates user' do
        expect do
          post :create, params: { user: { email: 'tt@test.tt', name: 'Vasya' } }
        end.not_to change(User, :count)
      end

      it 'responds with flash' do
        post :create, params: { user: { email: 'tt@test.tt', name: 'Vasya' } }
        expect(flash).not_to be_nil
      end

      it 'not create organization with same inn' do
        org
        expect do
          post :create, params: { user: { email: 'tt@test.tt', name: 'Vasya',
                                          organization: org_params } }
        end.not_to change(Organization, :count)
      end

      it 'checks flash message' do
        org
        post :create, params: { user: { email: 'tt@test.tt', name: 'Vasya',
                                        organization: org_params } }
        expect(flash[:error][:"organization.inn"])
          .to eq [I18n.t('activemodel.errors.models.organization.attributes.inn.taken')]
      end
    end

    context 'when create user and organization' do
      let(:request) do
        params = { email: 'tt@test.tt', name: 'Vasya', organization: org_params }
        post :create, params: { user: params }
      end

      it 'creates user' do
        expect do
          request
        end.to change(User, :count).by 1
      end

      it 'creates organization' do
        expect do
          request
        end.to change(Organization, :count).by 1
      end

      it 'organization has user' do
        request
        new_user = User.find_by(email: 'tt@test.tt')
        expect(new_user.organization).not_to be_nil
      end

      it 'creates organization if it\'s not exists and mark as contact' do
        request
        new_user = User.find_by(email: 'tt@test.tt')
        expect(new_user.reload.contact).to be true
      end

      it 'sends email with password' do
        expect(WelcomeMailer).to receive_message_chain(:welcome_email, :deliver_later)
        request
      end

      context 'check organization attributes' do
        before { request }

        subject { Organization.find_by(inn: '1231231231') }

        it 'check name' do
          expect(subject.name).to eq 'Example'
        end

        it 'check contact' do
          expect(subject.contact_user.name).to eq 'Vasya'
        end
      end
    end
  end
end
