require 'spec_helper'

describe SettingsController do
  before { @admin = User.create(name: "admin", password: "admin", password_confirmation: "admin") }
  let(:valid_attributes) { { "key" => "key_#{SecureRandom.hex}", "value" => "test_value", "protected" => "none" } }
  let(:valid_session) { { user_id: @admin.id } }

  describe "authorized" do
    describe "GET index" do
      it "assigns all settings as @settings" do
        setting = Setting.create! valid_attributes
        get :index, {}, valid_session
        assigns(:settings).should eq([setting])
      end
    end

    describe "GET new" do
      it "assigns a new setting as @setting" do
        get :new, {}, valid_session
        assigns(:setting).should be_a_new(Setting)
      end
    end

    describe "GET edit" do
      it "assigns the requested setting as @setting" do
        setting = Setting.create! valid_attributes
        get :edit, { id: setting.to_param }, valid_session
        assigns(:setting).should eq(setting)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Setting" do
          expect {
            post :create, { setting: valid_attributes }, valid_session
          }.to change(Setting, :count).by(1)
        end

        it "assigns a newly created setting as @setting" do
          post :create, { setting: valid_attributes }, valid_session
          assigns(:setting).should be_a(Setting)
          assigns(:setting).should be_persisted
        end

        it "redirects to the created setting" do
          post :create, {:setting => valid_attributes}, valid_session
          response.should redirect_to(Setting.last)
        end
      end

      # describe "with invalid params" do
      #   it "assigns a newly created but unsaved setting as @setting" do
      #     Setting.any_instance.stub(:save).and_return(false)
      #     post :create, { setting: invalid_attributes }, valid_session
      #     assigns(:setting).should be_a_new(Setting)
      #   end

      #   it "re-renders the 'new' template" do
      #     # Trigger the behavior that occurs when invalid params are submitted
      #     Setting.any_instance.stub(:save).and_return(false)
      #     post :create, {:setting => { "key" => "invalid value" }}, valid_session
      #     response.should render_template("new")
      #   end
      # end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested setting" do
          setting = Setting.create! valid_attributes
          Setting.any_instance.should_receive(:update).with({ "key" => "MyString" })
          put :update, {:id => setting.to_param, :setting => { "key" => "MyString" }}, valid_session
        end

        it "assigns the requested setting as @setting" do
          setting = Setting.create! valid_attributes
          put :update, { id: setting.to_param, setting: valid_attributes }, valid_session
          assigns(:setting).should eq(setting)
        end

        # it "redirects to the setting" do
        #   setting = Setting.create! valid_attributes
        #   put :update, {:id => setting.to_param, :setting => valid_attributes}, valid_session
        #   response.should redirect_to(setting)
        # end
      end

      # describe "with invalid params" do
      #   it "assigns the setting as @setting" do
      #     setting = Setting.create! valid_attributes
      #     # Trigger the behavior that occurs when invalid params are submitted
      #     Setting.any_instance.stub(:save).and_return(false)
      #     put :update, {:id => setting.to_param, :setting => { "key" => "invalid value" }}, valid_session
      #     assigns(:setting).should eq(setting)
      #   end

      #   it "re-renders the 'edit' template" do
      #     setting = Setting.create! valid_attributes
      #     # Trigger the behavior that occurs when invalid params are submitted
      #     Setting.any_instance.stub(:save).and_return(false)
      #     put :update, {:id => setting.to_param, :setting => { "key" => "invalid value" }}, valid_session
      #     response.should render_template("edit")
      #   end
      # end
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
