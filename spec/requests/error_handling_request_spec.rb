# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Error handling', type: :request do
  describe 'rescue StandardError' do
    let!(:user) { create(:user_with_organization) }

    before do
      allow_any_instance_of(PagesController).to receive(:index).and_raise(StandardError)
    end

    subject { get '/' }

    context 'when rsponse with html' do
      it 'sends email to slack' do
        expect(ExceptionNotifier).to receive(:notify_exception)
        subject
      end

      it 'redirects to root' do
        expect(subject).to redirect_to root_path
      end

      it 'sets flash' do
        subject
        expect(flash['alert']).not_to be_empty
      end
    end
  end
end
