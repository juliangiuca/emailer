
module Emailer
  module Boot
    module Controller
      def self.include_controllers!(klass)
        Dir.glob(File.join(RACK_ROOT, "app", "controllers", "*_controller.rb")).each do |file|
          require file
          basename = File.basename(file, ".rb")
          klass.send(:include, "Emailer::#{basename.classify}".constantize)
        end
      end
    end
  end
end
