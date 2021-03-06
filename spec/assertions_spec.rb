require 'spec_helper'
require 'watirmark'

describe Watirmark::Assertions do
  include Watirmark::Assertions
  
  it 'can compare simple elements' do
    element = stub(:exists? => true, :value => 'giant vampire squid', :radio_map => nil)
    assert_equal element, 'giant vampire squid'
  end
  
  it 'compare integer' do
    element = stub(:exists? => true, :value => '100')
    assert_equal element, 100
  end

  it 'compare string integer' do
    element = stub(:exists? => true, :value => '100')
    assert_equal element, '100'
  end

  it 'expecting value with with percent' do
    element = stub(:exists? => true, :value => '100%')
    assert_equal element, '100%'
  end

  it 'expecting value with with a currency symbol' do
    element = stub(:exists? => true, :value => '$123.45')
    assert_equal element, '$123.45'
  end

  it 'expecting integer value should strip the dollar sign' do
    element = stub(:exists? => true, :value => '$25')
    assert_equal element, '25'
    assert_equal element, '$25'
    lambda { assert_equal element, '25%' }.should raise_error
  end

  it 'symbol in wrong place needs to match exactly or fail' do
    element = stub(:exists? => true, :value => '25$')
    lambda { assert_equal element, '$25' }.should raise_error
    assert_equal element, '25$'

    element = stub(:exists? => true, :value => '%50')
    lambda { assert_equal element, '50%' }.should raise_error
    lambda { assert_equal element, '50' }.should raise_error
    assert_equal element, '%50'
  end

  it 'should detect two different numbers are different' do
    element = stub(:exists? => true, :value => '50')
    lambda { assert_equal element, '51' }.should raise_error
    lambda { assert_equal element, '50.1' }.should raise_error
    lambda { assert_equal element, 49.9 }.should raise_error
    lambda { assert_equal element, 49 }.should raise_error
    assert_equal element, 50.0
  end

  it 'should let a number match a number with a $ before or % after' do
    element = stub(:exists? => true, :value => '$26', :name => 'unittest')
    assert_equal element, 26
    element = stub(:exists? => true, :value => '27%', :name => 'unittest')
    assert_equal element, 27.00
  end

  it 'should let a number in a string match a number with currency or percent' do
    element = stub(:exists? => true, :value => '$36', :name => 'unittest')
    assert_equal element, '36'
    element = stub(:exists? => true, :value => '37%', :name => 'unittest')
    assert_equal element, '37.00'
  end
  
end
