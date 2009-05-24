require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes.rb'

ruby_version_is '1.8.7' do
  describe "String#partion with String" do
    it "returns an array of substrings based on splitting on the given string" do
      "hello world".partition(" ").should == ["hello", " ", "world"]
    end

    it "always returns 3 elements" do
      "hello".partition("x").should == ["hello", "", ""]
      "hello".partition("hello").should == ["", "hello", ""]
    end

    it "uses :to_str to convert" do
      "hello".partition("x").should == ["hello", "", ""]
      "hello".partition("hello").should == ["", "hello", ""]
    end

    it "accepts regexp" do
      "hello".partition(/l./).should == ["he", "ll", "o"]
    end

    ruby_bug "redmine #1510", '1.9.1' do
      it "converts its argument using :to_str" do
        find = mock('ll')
        find.should_receive(:to_str).and_return("ll")
        "hello".partition(find).should == ["he","ll","o"]
      end
    end

    it "raises error if not convertible to string" do
      lambda{ "hello".partition(5) }.should raise_error(TypeError)
      lambda{ "hello".partition(nil) }.should raise_error(TypeError)
    end
  end
end

ruby_version_is ''...'1.9' do
  describe "String#partion with a block" do
    it "is still available" do
      "hello\nworld".partition{|w| w < 'k' }.should == [["hello\n"], ["world"]]
    end
  end
end