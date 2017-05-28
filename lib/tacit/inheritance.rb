module Tacit
  module Inheritance
    refine Module do
      alias_method :*,  def Combines(*from, &block)
                          if nebulous?
                            Module.new(&block).include(*from, *extentions)
                          else
                            Module.new(&block).include(*from, self)
                          end
                        end

      alias_method :+,  def As(base)
                          if nebulous?
                            base::Combines(*extentions)
                          else
                            base * self
                          end
                        end

      alias_method :+@, def as_base_class
                          As(Class.new)
                        end

      alias_method :>>, def Overlays(base)
                          if nebulous?
                            base::With(*extentions)
                          else
                            base << self
                          end
                        end

      alias_method :<<, def With(*overlayers)
                          if nebulous?
                            prepend(*overlayers)
                          else
                            Module.new.prepend(*overlayers, self)
                          end
                        end

      def extentions; ancestors.tap { |a| a.delete self } end
      def nebulous?; name.nil? && instance_methods(false).empty? end
    end # Module refinement

    refine Class do
      alias_method :*,  def Combines(*from, &block)
                          subclass = as_base_class
                          subclass.include(*from) unless from.empty?
                          subclass.class_eval(&block) if block_given?
                          subclass
                        end

      alias_method :+,  def As(_ = nil)
                          raise NoMethodError, "undefined method '#{__callee__}' for #{self}:Class", caller
                        end

      alias_method :+@, def as_base_class
                          nebulous? ? self : Class.new(self)
                        end

      alias_method :>>, def Overlays(_ = nil)
                          raise NoMethodError, "undefined method '#{__callee__}' for #{self}:Class", caller
                        end

      alias_method :<<,  def With(*overlay)
                          as_base_class.prepend(*overlay)
                        end
    end # Class refinement
  end # Inheritance module
end # Tacit module
