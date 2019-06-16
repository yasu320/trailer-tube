RSpec.describe ReviewsController, type: :controller do
  describe "#index" do
    let(:video) { create(:video, :with_reviews) }

    before do
      get :index, params: { video_id: video.id }
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

    it "assigns @reviews" do
      expect(assigns(:reviews)).to match_array(video.reviews)
    end
  end

  describe "#show" do
    let(:video) { create(:video, :with_reviews) }

    before do
      @review = video.reviews.sample
      get :show, params: { id: @review.id, video_id: video.id }
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "renders the index template" do
      expect(response).to render_template("show")
    end

    it "assigns @review" do
      expect(assigns(:review)).to eq @review
    end
  end
end
