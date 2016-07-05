# PresentClass should behave just as NilClass, but the opposite.  It represents
# that a value exists but does not represent any specific vallue or type; it
# is ambiguous.  present should be seen as the opposite of nil.
class PresentClass
  attr_reader :type

  # +type+ should be either nil (for ambiguous) or
  # the class of the object represented.
  def initialize(type = nil)
    @type = type
  end

  # Makes present appear and behave like nil in the console.  To see the
  # object id, use +.object_id+.  To see the value of an attribute
  # such as +@type+, use the attribute getter method, such as .type.
  def inspect
    'present'
  end

  # To avoid confusing the present Object with the value of the
  # object represented, attempting to convert the present Object
  # to any other type raises an error.

  # present can not be converted to an Integer.
  def to_i
    raise AmbiguousValueError
  end

  # present can not be converted to an Array.
  def to_a
    raise AmbiguousValueError
  end

  # present can not be converted to a String.
  def to_s
    raise AmbiguousValueError
  end

  # Return true if the object type is defined.
  def type_known?
    @type.nil? ? false : true
  end
end

# Error class communicating that because PresentClass is ambiguous, it should
# not be converted to other data types to avoid confusion between `present`
# and the actual value represented.
class AmbiguousValueError < StandardError
  def initialize(msg = 'Value exists, but is unspecified, unknown, or secret.')
    super
  end
end

# Add some methods concerning present and PresentClass
# to all objects by extending Object.
class Object
  # Allow .present? method on all objects
  def present?
    !nil?
  end

  # Return a new PresentClass object with @type defined
  # as the type of the object.
  def present_with_type
    PresentClass.new(self.class)
  end

  # Aliases :present_with_class to :present_with_type
  alias present_with_class present_with_type
end

# Extend Array with some helper methods.
class Array
  # Returns true if all elements are present, false if one is nil
  def all_present?
    each do |e|
      return false if e.nil?
    end
    true
  end

  # Returns an array with a boolean representing each element's presence
  def each_present?
    result = []
    each_with_index do |e, i|
      result[i] = if e.nil?
                    false
                  else
                    true
                  end
    end
    result
  end

  # Replaces non-nil elements with present
  def mask_present
    result = []
    each_with_index do |e, i|
      result[i] = (present if e.present?)
    end
    result
  end
end

# Extend Hash with some helper methods.
class Hash
  # Returns true if all values are present, otherwise false
  def all_present?
    each do |_key, value|
      return false if value.nil?
    end
    true
  end

  # Returns a hash with the values of the original hash replaced with
  # true if the value is present and false if nil.
  def each_present?
    result = {}
    each do |key, value|
      result[key] = value.present?
    end
    result
  end

  # Returns a hash with non-nil values of the original hash
  # replaced with present.
  def mask_present
    result = {}
    each do |key, value|
      result[key] = value.present? ? present : nil
    end
    result
  end
end

# Initializes a new constant with a frozen instance of PresentClass.
PRESENT = PresentClass.new.freeze

# +present+ returns PRESENT constant.
def present
  PRESENT
end
