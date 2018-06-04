require 'spec_helper'

describe Light::Model do
  class TestClass < Light::Model
    attributes :name, :email, :bucket
  end

  let(:test_data) { {name: 'Pawel', email: 'pniemczyk@o2.pl', bucket: { test_key: 'stuff'}} }
  before(:each) { @subject = TestClass.new(test_data) }

  context 'initialize' do
    it 'fillfull instance' do
      @subject.name.should   eq test_data[:name]
      @subject.email.should  eq test_data[:email]
      @subject.bucket.should eq test_data[:bucket]
    end
  end

  context '#to_h' do
    it 'default' do
      @subject.to_h.symbolize_keys.should eq test_data
    end

    it 'with options' do
      hash = {'name' => 'Pawel'}
      @subject.to_h(only: :name).should eq hash
    end
  end

  context 'equality' do
    it 'two instance with same data should be eq' do
      [
        TestClass.new(test_data) == TestClass.new(test_data),
        TestClass.new(test_data).eql?(TestClass.new(test_data))
      ].all?.should eq(true)
    end
  end

  context '#as_json' do
    it 'default' do
      @subject.as_json.should eq test_data.stringify_keys
    end

    it 'with options' do
      hash = { 'name' => 'Pawel' }
      @subject.as_json(only: :name).should eq hash.stringify_keys
    end
  end

  context '#to_json' do
    it 'default' do
      @subject.to_json.should eq test_data.to_json
    end

    it 'with options' do
      hash = { 'name' => 'Pawel' }
      @subject.to_json(only: :name).should eq hash.to_json
    end
  end

  context '#persisted?' do
    it 'by default returns false' do
      @subject.persisted?.should eq false
    end

    context 'when persisted_via_attr is setup' do
      before { @subject.class.persisted_via_attr :name }
      it 'returns true when attr value present' do
        @subject.persisted?.should eq true
      end

      it 'returns false when attr value is blank' do
        @subject.name = nil
        @subject.persisted?.should eq false
      end
    end
  end
end
