module Liquidizer
  module LiquidTemplate
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def find_by_name(name)
        if name.present?
          find_by(:name => name) || find_default_by_name(name)
        end
      end

      def find_default_by_name(name)
        if name.present?
          Liquidizer.template_paths.each do |path|
            file_name = File.join(path, name) + '.liquid'

            if File.exist?(file_name)
              return new(:name => name, :content => File.read(file_name))
            end
          end
        end

        nil
      end
    end
  end
end
