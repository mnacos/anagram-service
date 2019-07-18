require 'rails_helper'

RSpec.describe AnagramsController, type: :controller do

  describe "GET #show" do
    context "input exists in the worldist" do
      before(:each) do
        %w[pinkish kinship].each { |v| Word.create(value: v) }
      end

      it "returns http success" do
        get :show, params: { query: 'kinship' }
        expect(response).to have_http_status(:success)
      end

      it "returns anagrams in the json response" do
        get :show, params: { query: 'kinship' }
        expect(response.body).to eq('{"kinship":["pinkish"]}')
      end
    end

    context "input is not in the worldlist" do
      it "returns http success" do
        get :show, params: { query: 'sdfwehrtgegfg' }
        expect(response).to have_http_status(:success)
      end

      it "returns empty list in json response" do
        get :show, params: { query: 'sdfwehrtgegfg' }
        expect(response.body).to eq('{"sdfwehrtgegfg":[]}')
      end
    end

    context "multiple words are supplied" do
      before(:each) do
        words = %w[and paste pates peats septa spate tapes tepas pinkish kinship fresher refresh]
        words.each { |v| Word.create(value: v) }
      end

      it "returns anagrams per word supplied" do
        get :show, params: { query: 'paste,kinship,fresher,sdfwehrtgegfg' }
        expect(response.body).to eq('{"paste":["pates","peats","septa","spate","tapes","tepas"],"kinship":["pinkish"],"fresher":["refresh"],"sdfwehrtgegfg":[]}')
      end
    end
  end

end
