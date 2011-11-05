require 'spec_helper'

describe Task do
  before(:each) do
    @task = Factory(:task)
  end

  it "should respond to user" do
    @task.should respond_to(:user)
  end

end
