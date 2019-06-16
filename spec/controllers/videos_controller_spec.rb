RSpec.describe VideosController, type: :controller do
  describe "#index" do
    let(:video) { create(:video) }

    before do
      get :index
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "assigns @videos" do
      expect(assigns(:videos)).to eq([video])
    end
  end

  describe "#show" do
    let(:video) { create(:video, :with_reviews) }

    before do
      get :show, params: { id: video.id }
    end

    it "renders th show template" do
      expect(response).to render_template("show")
    end

    it "assigns @video" do
      expect(assigns(:video)).to eq video
    end

    it "assigns @reviews" do
      expect(assigns(:reviews)).to match_array(video.reviews)
    end
  end

  describe "#search" do
    before do
      get :search
    end

    it "renders th show template" do
      expect(response).to render_template("index")
    end
  end
end
