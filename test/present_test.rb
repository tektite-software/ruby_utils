require 'test_helper'

describe 'Global methods and constants' do
  it 'must have the PRESENT constant' do
    PRESENT.wont_be_nil
  end

  it 'must have PRESENT be a PresentClass' do
    PRESENT.must_be_instance_of PresentClass
  end

  it 'must have a `present` method which equals PRESENT' do
    present.must_be_same_as PRESENT
  end

  it 'present must return "present" when inspected' do
    PRESENT.inspect.must_equal "present"
    present.inspect.must_equal "present"
    PresentClass.new.inspect.must_equal "present"
  end
end

describe PresentClass do
  before do
    @present_string = PresentClass.new(type: String)
  end

  it 'should not be convertable to other types' do
    -> { present.to_i }.must_raise AmbiguousValueError
    -> { present.to_a }.must_raise AmbiguousValueError
    -> { present.to_s }.must_raise AmbiguousValueError
  end

  it 'should by default return nil for @type' do
    present.type.must_be_nil
  end

  it 'should return a class when type is defined' do
    @present_string.type.must_be_kind_of Class
  end

  describe 'when calling type_known?' do
    it 'should return false by default' do
      present.type_known?.must_equal false
    end

    it 'should return true when the type is defined' do
      @present_string.type_known?.must_equal true
    end
  end
end

describe Object do
  before do
    @test_string = 'This is a test'
    @test_nil = nil
  end

  it 'should respond to present?' do
    @test_string.must_respond_to :present?
  end

  describe 'when .present? is called' do
    it 'should return true when not nil' do
      @test_string.present?.must_equal true
    end

    it 'should return false when nil' do
      @test_nil.present?.must_equal false
    end
  end

  describe 'when .present_with_type is called' do
    it 'should return a PresentClass object' do
      @test_string.present_with_type.must_be_instance_of PresentClass
    end

    it 'should return a PresentClass not equal to PRESENT' do
      @test_string.present_with_type.wont_be_same_as present
    end

    it 'should have a .type defined on the returned object' do
      @test_string.present_with_type.type.must_equal String
    end
  end
end

describe Array do
  before do
    @test_array = [1, 2, 3, 4, nil, 5]
    @test_array_2 = [1, 2, 3]
  end

  it 'should react properly to .all_present?' do
    @test_array.all_present?.must_equal false
    @test_array_2.all_present?.must_equal true
  end

  it 'should react properly to .each_present?' do
    @test_array.each_present?.must_be_instance_of Array
    @test_array.each_present?.must_equal [true, true, true, true, false, true]
    @test_array_2.each_present?.must_equal [true, true, true]
  end

  it 'should react properly to .mask_present' do
    @test_array.mask_present.must_be_instance_of Array
    @test_array.mask_present.must_equal [
      present, present, present, present, nil, present
    ]
    @test_array_2.mask_present.must_equal [present, present, present]
  end

  it 'should not change original array' do
    @test_array.mask_present
    @test_array.all_present?
    @test_array.each_present?
    @test_array.must_equal [1, 2, 3, 4, nil, 5]
  end
end

describe Hash do
  before do
    @test_hash = Hash(one: 1, two: 2, three: nil)
    @test_hash_2 = Hash(alpha: nil, bravo: 'two')
    @test_hash_3 = Hash(first: 1, second: 2)
  end

  it 'should react properly to .all_present?' do
    @test_hash.all_present?.must_equal false
    @test_hash_2.all_present?.must_equal false
    @test_hash_3.all_present?.must_equal true
  end

  it 'should react properly to .each_present?' do
    @test_hash.each_present?.must_be_instance_of Hash
    @test_hash.each_present?.must_equal Hash(one: true, two: true, three: false)
    @test_hash_2.each_present?.must_equal Hash(alpha: false, bravo: true)
  end

  it 'should react properly to .mask_present' do
    @test_hash.mask_present.must_be_instance_of Hash
    @test_hash.mask_present.must_equal Hash(
      one: present, two: present, three: nil
    )
    @test_hash_2.mask_present.must_equal Hash(alpha: nil, bravo: present)
  end

  it 'should not change original hash' do
    @test_hash.mask_present
    @test_hash.all_present?
    @test_hash.each_present?
    @test_hash.must_equal Hash(one: 1, two: 2, three: nil)
  end
end

describe 'TektiteRubyUtils::Present' do
  it 'should be equal to PRESENT' do
    TektiteRubyUtils::Present.must_be_same_as PRESENT
  end
end
