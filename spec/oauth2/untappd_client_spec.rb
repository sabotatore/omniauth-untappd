require 'spec_helper'

describe OAuth2::UntappdClient do
  subject(:client) { OAuth2::UntappdClient.new('abc', 'def') }

  context '#get_token' do
    subject { client.get_token({}) }
    let(:response) { double('Response', parsed: parsed_response, body: parsed_response) }

    before { client.stub(request: response) }

    context 'correct response' do
      let(:parsed_response) {{ 'response' => { 'access_token' => 'ACCESSTOKEN' }}}

      its(:token) { should eql 'ACCESSTOKEN' }
    end

    context 'incorrect response' do
      let(:parsed_response) { 'unknown error' }
      before { response.should_receive(:error=) }

      it { expect { subject }.to raise_error(OAuth2::Error, parsed_response) }
    end
  end
end
