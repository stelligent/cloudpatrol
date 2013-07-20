require 'spec_helper'

describe SettingsController do
  before { @admin = User.find_by_name("admin") }
  let(:valid_attributes) { { "key" => "key_#{SecureRandom.hex}", "value" => "test_value", "protected" => "none" } }
  let(:valid_session) { { user_id: @admin.id } }

  describe "authorized" do
    describe "GET index" do
      it "assigns all settings as @settings" do
        setting = Setting.create! valid_attributes
        get :index, {}, valid_session
        assigns(:settings).should include(setting)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Setting" do
          expect {
            post :create, { setting: valid_attributes, format: :js }, valid_session
          }.to change(Setting, :count).by(1)
        end

        it "assigns a newly created setting as @setting" do
          post :create, { setting: valid_attributes, format: :js }, valid_session
          assigns(:setting).should be_a(Setting)
          assigns(:setting).should be_persisted
        end

        it "assigns @success as true" do
          post :create, { setting: valid_attributes, format: :js }, valid_session
          assigns(:success).should be_true
        end

        it "renders the response" do
          post :create, { setting: { key: "" }, format: :js }, valid_session
          response.status.should == 200
        end
      end

      describe "with invalid params" do
        it "assigns @success as false" do
          Setting.any_instance.stub(:save).and_return(false)
          post :create, { setting: { key: "" }, format: :js }, valid_session
          assigns(:success).should be_false
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested setting" do
          setting = Setting.create! valid_attributes
          Setting.any_instance.should_receive(:update).with({ "key" => "test_string" })
          put :update, {id: setting.to_param, setting: { key: "test_string" }, format: :js}, valid_session
        end

        it "assigns the requested setting as @setting" do
          setting = Setting.create! valid_attributes
          put :update, { id: setting.to_param, setting: valid_attributes, format: :js }, valid_session
          assigns(:setting).should eq(setting)
        end

        it "renders the response" do
          setting = Setting.create! valid_attributes
          put :update, { id: setting.to_param, setting: valid_attributes, format: :js}, valid_session
          response.status.should == 200
        end
      end

      describe "with invalid params" do
        it "assigns @success as false" do
          setting = Setting.create! valid_attributes
          Setting.any_instance.stub(:save).and_return(false)
          put :update, { id: setting.to_param, setting: { key: "" }, format: :js}, valid_session
          assigns(:success).should be_false
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested setting" do
        setting = Setting.create! valid_attributes
        expect {
          delete :destroy, { id: setting.to_param }, valid_session
        }.to change(Setting, :count).by(-1)
      end

      it "redirects to the settings list" do
        setting = Setting.create! valid_attributes
        delete :destroy, { id: setting.to_param }, valid_session
        response.should redirect_to(settings_url)
      end
    end
  end
end
