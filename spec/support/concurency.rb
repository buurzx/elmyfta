# frozen_string_literal: true
module Concurency
  def make_concurrent_calls(_method, _objects)
    process1, process2 = dreds.map do |obj|
      ForkBreak::Process.new do |breakpoints|
        # We need to reconnect after forking
        ActiveRecord::Base.establish_connection
        # Add a breakpoint after invoking save
        original_method = obj.method(:save)
        obj.stub(:save) do
          value = original_method.call
          breakpoints << :method_point
          value
        end

        obj.send(:save)
      end
    end
    process1.run_until(:method_point).wait
    process2.run_until(:method_point).wait

    process1.finish.wait
    process2.finish.wait
  end
end
