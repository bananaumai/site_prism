# frozen_string_literal: true

module SitePrism
  class Waiter
    def self.wait_until_true(wait_time = Capybara.default_max_wait_time)
      start_time = Time.now

      loop do
        return true if yield
        break if Time.now - start_time > wait_time
        sleep(0.05)
      end

      raise SitePrism::TimeoutError, "Timed out after #{wait_time}s."
    end

    def self.wait_until_displayed?(*args)
      expected_mappings = args.last.is_a?(::Hash) ? args.pop : {}
      seconds = !args.empty? ? args.first : Capybara.default_max_wait_time

      wait_until_true(seconds) { yield expected_mappings }
    end
  end
end
