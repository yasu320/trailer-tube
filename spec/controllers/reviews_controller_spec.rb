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

  describe "#new" do
    let(:video) { create(:video) }

    before do
      @user = create(:user)
      sign_in @user
      get :new, params: { video_id: video.id }
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns @review" do
      expect(assigns(:review)).to be_a_new Review
    end
  end

  describe "#create" do
    let(:video) { create(:video) }

    context "as an authenticated user" do
      before do
        @user = create(:user)
      end

      it "adds a review" do
        review_params = attributes_for(:review)
        sign_in @user
        expect { post :create, params: { video_id: video.id, review: review_params } }.to change(@user.reviews, :count).by(1)
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        review_params = attributes_for(:review)
        post :create, params: { video_id: video.id, review: review_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        review_params = attributes_for(:review)
        post :create, params: { video_id: video.id, review: review_params }
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "#user_reviews" do
    let(:user) { create(:user) }
    let(:review) { create(:review, user_id: user.id) }

    before do
      get :user_reviews, params: { user_id: user.id }
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "renders the new template" do
      expect(response).to render_template("user_reviews")
    end

    it "assigns @user" do
      expect(assigns(:user)).to eq user
    end

    it "assigns @videos" do
      expect(assigns(:videos)).to eq([review.video])
    end
  end
end
