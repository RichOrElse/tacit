require "test_helper"

module Tacit
  using Inheritance

  class InheritanceTest < Minitest::Test
    Cat = Class.new
    Curious = Module.new
    Friendly = Module.new

    def test_module_Overlays
      overlays = Curious >> Friendly >> Cat
      assert_equal [Curious, Friendly, overlays, Cat], overlays.ancestors.first(4)
    end

    def test_module_With
      with = Cat << Curious << Friendly
      assert_equal [Friendly, Curious, with, Cat], with.ancestors.first(4)
    end

    def test_module_Combines
      combines = Cat * Curious * Friendly
      assert_equal [combines, Friendly, Curious, Cat], combines.ancestors.first(4)
    end

    def test_module_Combines_with_block
      combines = Friendly::Combines() { def greet; 'Hello!' end }
      assert_includes combines.instance_methods, :greet
    end

    def test_module_As
                    as = Curious + Friendly + Cat
      assert_equal [as, Curious, Friendly, Cat], as.ancestors.first(4)
    end

    def test_module_as_base_class
                    as_base_class = +Curious
      assert_equal [as_base_class, Curious], as_base_class.ancestors.first(2)
      assert_instance_of Class, as_base_class
    end

    def test_class_as_base_class
                    as_base_class = +Cat
      assert_equal [as_base_class, Cat], as_base_class.ancestors.first(2)
      assert_operator as_base_class, :<, Cat
    end

    def test_class_has_no_Overlays_methods
      exception = assert_raises(NoMethodError) { Cat >> Curious }
      exception = assert_raises(NoMethodError) { Cat::Overlays(Curious) }
      assert_equal("undefined method 'Overlays' for #{Cat}:Class", exception.message)
    end

    def test_class_has_no_as_methods
      exception = assert_raises(NoMethodError) { Cat + Curious }
      exception = assert_raises(NoMethodError) { Cat::As Curious }
      assert_equal("undefined method 'As' for #{Cat}:Class", exception.message)
    end

    def test_class_Combines_with_block
      combines = Cat::Combines() { def meow; 'meow' end }
      assert_includes combines.instance_methods, :meow
    end
  end
end
