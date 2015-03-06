require 'spec_helper'

describe OmniAuth::Strategies::Untappd do
  subject(:strategy) { OmniAuth::Strategies::Untappd.new('client_id', 'client_secret') }

  before { OmniAuth.config.test_mode = true }
  after { OmniAuth.config.test_mode = false }

  let(:parsed_response) {{ 'response' => {
                             'user' => {
                               'id' => '123',
                               'first_name' => 'John',
                               'last_name' => 'Doe',
                               'user_name' => 'john_doe',
                               'untappd_url' => 'https://untappd.com/user/john_doe',
                               'settings' => {
                                 'email_address' => 'john@doe'
                               }
                             }
                            }}}

  context 'options' do
    subject(:options) { strategy.options }

    its(:name) { should eql 'untappd' }
    its(:provider_ignores_state) { should be_true }

    context 'client options' do
      subject { options.client_options }

      its(:site) { should eql 'https://untappd.com' }
      its(:authorize_url) { should eql '/oauth/authenticate' }
      its(:token_url) { should eql '/oauth/authorize' }
      its(:token_method) { should eql :get }
    end

    context 'token_params' do
      subject { options.token_params }

      its(:parse) { should eql :json }
    end
  end

  describe 'add redirect_url to params' do
    let(:callback_url) { 'callback_url' }
    before { expect(strategy).to receive(:callback_url).and_return(callback_url) }

    context '#token_params' do
      subject { strategy.token_params }

      its(:redirect_url) { should eql callback_url }
    end

    context '#authorize_params' do
      subject { strategy.authorize_params }

      its(:redirect_url) { should eql callback_url }
    end
  end

  context '#raw_info' do
    subject { strategy.raw_info }
    let(:access_token) { double('AccessToken', options: {}) }
    let(:response) { double('Response', parsed: parsed_response) }
    let(:user_info_url) { 'https://api.untappd.com/v4/user/info' }

    before { strategy.stub(access_token: access_token) }
    before { expect(access_token).to receive(:get).with(user_info_url).and_return(response) }

    it { should eql(parsed_response['response']['user']) }

    context '#uid' do
      subject { strategy.uid }

      it { should eql '123' }
    end

    context '#info' do
      subject(:info) { strategy.info }

      it { expect(info[:name]).to eql 'John Doe' }
      it { expect(info[:nickname]).to eql 'john_doe' }
      it { expect(info[:email]).to eql 'john@doe' }
      it { expect(info[:urls]['Untappd']).to eql 'https://untappd.com/user/john_doe' }
    end

    context '#extra' do
      it { expect(strategy.extra[:raw_info]).to eql strategy.raw_info }
    end
  end

  context 'client' do
    subject { strategy.client }

    it { should be_a_kind_of OAuth2::UntappdClient }
  end

end
