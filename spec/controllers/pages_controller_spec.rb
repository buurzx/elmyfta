# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

RSpec.describe PagesController, type: :controller do
  describe 'GET #index' do
    let(:organizations) do
      ['ИП Смирнов', 'ООО ЭлМу', 'ООО КЗТЧ'].each do |name|
        create(:organization, name: name, inn: rand(1_000_000_000..9_999_999_999))
      end
    end

    let(:products) do
      ['3КВ(Н)ТпН-1-70/120', 'EMKT-6O/50-95', 'POLJ-01/4x25-70-T'].each do |name|
        create(:product, name: name, organization: Organization.first)
      end
    end

    before { organizations and products } # rubocop: disable Style/AndOr

    context 'when search organization' do
      it 'responds with success' do
        get :index, params: { search_type: '1', q: 'кзтч' }
        expect(response.status).to eq 200
      end

      it 'responds with result' do
        org = Organization.find_by(name: 'ООО КЗТЧ')
        get :index, params: { search_type: '1', q: 'кзтч' }
        res = controller.instance_variable_get(:@result)
        expect(res[:objects]).to eq [org]
      end
    end

    context 'when search product' do
      it 'responds with success' do
        get :index, params: { q: 'емкт' }
        expect(response.status).to eq 200
      end

      it 'responds with result' do
        product = Product.find_by(name: 'EMKT-6O/50-95')
        get :index, params: { q: 'EMKT' }
        res = controller.instance_variable_get(:@result)
        expect(res[:objects]).to eq [product]
      end
    end
  end
end
