# frozen_string_literal: true

include ActionDispatch::TestProcess

RSpec.describe ParserService do
  describe '#parse_and_create' do
    let!(:prod1) { fixture_file_upload('files/prods.xlsx') }
    let!(:prod2) { fixture_file_upload('files/prod2.xlsx') }
    let!(:organization) { create(:organization, inn: '5551123132', name: 'Simple') }
    let!(:organization1) { create(:organization, inn: '5571123132', name: 'Simpla') }
    let!(:user) { create(:user, password: '123132', organization: organization) }
    let!(:user1) { create(:user, password: '123444', organization: organization1) }

    it 'check validity of file' do
      service = ParserService.new(file: prod1, user: user)
      service.parse_and_create
      expect(service.error.blank?).to be_truthy
    end

    it 'check validity of correct file' do
      service = ParserService.new(file: prod2, user: user)
      service.parse_and_create
      expect(service.error.blank?).to be_truthy
    end
  end
end
