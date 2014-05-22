require 'spec_helper'
require 'action_controller'

describe Doodoo::NestedLoadAndAuthorize do

  class ChildController < ActionController::Base
    include Doodoo::NestedLoadAndAuthorize
  end

  class ToyController < ActionController::Base
    include Doodoo::NestedLoadAndAuthorize
  end

  context "loading a model" do
    let(:can_can_class) { double("CanCan class") }
    let(:child_controller) { ChildController.new }
    let(:toy_controller) { ToyController.new }
    let(:child) { double("Amelia") }
    let(:toy) { double("Peppa Pig doll") }
    before { ActionController::Base.stub(:cancan_resource_class => can_can_class) }

    it "loads a model" do
      can_can_resource = double("can can resource")
      can_can_class.should_receive(:new).with(child_controller, :child, {}).and_return(can_can_resource)
      can_can_resource.should_receive(:load_resource).and_return(child)
      can_can_resource.should_receive(:authorize_resource)
      child_controller.load_and_authorize :child
      expect(child_controller.loaded_resources).to match_array([child])
    end

    it "loads a nested model" do
      can_can_resource = double("can can resource")
      can_can_resource_2 = double("can can resource")
      can_can_class.should_receive(:new).with(toy_controller, :child, {}).and_return(can_can_resource)
      can_can_class.should_receive(:new).with(toy_controller, :toy, {:through => :child}).and_return(can_can_resource_2)
      can_can_resource.should_receive(:load_resource).and_return(child)
      can_can_resource.should_receive(:authorize_resource)
      can_can_resource_2.should_receive(:load_resource).and_return(toy)
      can_can_resource_2.should_receive(:authorize_resource)

      toy_controller.load_and_authorize :child do
        toy_controller.load_and_authorize :toy
      end
      expect(toy_controller.loaded_resources).to match_array([child, toy])
    end
  end
end
