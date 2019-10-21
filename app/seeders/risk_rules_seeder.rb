module BasicData
  module ProtoPlugin
    ##
    # Seeders defined under `BasicData::<PluginNameSpace>` get discovered by the core
    # automatically.
    class RiskRulesSeeder < Seeder
      ##
      # The Seeder's main method called during `rake db:seed`.
      def seed_data!
        RiskRule.transaction do
          risk_rules_names.each do |name|
            RiskRule.create name: name
          end
        end
      end

      ##
      # Don't run the seed if this method returns false to prevent seeding
      # over already existing data.
      #
      # Overrides the default (`true`) in its base class `Seeder`.
      def applicable?
        RiskRule.count == 0
      end

      ##
      # Message shown during `rake db:seed` as an explanation why this Seeder was skipped.
      #
      # Overrides the default message in its base class `Seeder`.
      def not_applicable_message
        'No need to seed Risks Rules as there already are some.'
      end

      def risk_rules_names
        %w(Klaus Herbert Felix)
      end
    end
  end
end
