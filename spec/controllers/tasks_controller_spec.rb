require 'spec_helper'

describe TasksController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'perform'" do
    it "returns http success" do
      get 'perform'
      response.should be_success
    end
  end

end
